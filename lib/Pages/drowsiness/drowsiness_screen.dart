import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class DetectionBox {
  final double x, y, width, height;
  final String label;
  final double confidence;

  DetectionBox({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.label,
    required this.confidence,
  });

  factory DetectionBox.fromJson(Map<String, dynamic> json) {
    return DetectionBox(
      x: json['x'].toDouble(),
      y: json['y'].toDouble(),
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      label: json['label'],
      confidence: json['confidence'].toDouble(),
    );
  }
}

class DrowsinessScreen extends StatefulWidget {
  const DrowsinessScreen({Key? key}) : super(key: key);

  @override
  _DrowsinessScreenState createState() => _DrowsinessScreenState();
}

class _DrowsinessScreenState extends State<DrowsinessScreen> {
  CameraController? _controller;
  bool _cameraInitialized = false;
  bool _showRetryButton = false;
  String _status = 'Đang khởi tạo camera...';
  bool _isDetecting = false;
  List<DetectionBox> _boxes = [];
  Timer? _detectionTimer;
  bool _isAlarmPlaying = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final String apiUrl = 'http://192.168.1.91:5000/api/detect_drowsiness';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _controller = CameraController(frontCamera, ResolutionPreset.medium, enableAudio: false);
      await _controller!.initialize();

      if (!mounted) return;
      setState(() {
        _cameraInitialized = true;
        _status = 'Camera đã sẵn sàng';
        _showRetryButton = false;
      });

      _startDetectionLoop();

    } catch (e) {
      if (!mounted) return;
      setState(() {
        _status = 'Lỗi camera: $e';
        _showRetryButton = true;
      });
    }
  }
  Future<void> _saveStatusToFirestore(String status) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userStatusRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('user_status');

      await userStatusRef.add({
        'status': status,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Lỗi lưu trạng thái vào Firestore: $e');
    }
  }
  void _startDetectionLoop() {
    _detectionTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_cameraInitialized && !_isDetecting) {
        _detectDrowsiness();
      }
    });
  }

  Future<void> _detectDrowsiness() async {
    if (_isDetecting || !_cameraInitialized || !mounted) return;

    setState(() {
      _isDetecting = true;
      _status = 'Đang phân tích...';
      _boxes.clear();
    });

    try {
      final image = await _controller!.takePicture();
      final bytes = await File(image.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      ).timeout(const Duration(seconds: 10));

      if (!mounted) return;

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          final drowsyDetected = result['drowsy_detected'] ?? false;
          final confidence = result['confidence'] ?? 0.0;
          final detectedStatus = drowsyDetected ? 'drowse' : 'awake';
          if(detectedStatus == 'drowse'){
            _saveStatusToFirestore(detectedStatus);
          }
          setState(() {
            _status = drowsyDetected
                ? '⚠️ Buồn ngủ phát hiện (${(confidence * 100).toStringAsFixed(1)}%)'
                : '✅ Bình thường';

            if (drowsyDetected && !_isAlarmPlaying) {
              _playAlarm();
            } else if (!drowsyDetected && _isAlarmPlaying) {
              _stopAlarm();
            }

            _boxes = result['boxes'] != null
                ? (result['boxes'] as List)
                    .map((boxJson) => DetectionBox.fromJson(boxJson))
                    .toList()
                : [];
          });
        } else {
          setState(() {
            _status = 'Lỗi phân tích: ${result['error'] ?? 'Không xác định'}';
          });
        }
      } else {
        setState(() {
          _status = 'Lỗi kết nối (${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Lỗi: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isDetecting = false;
        });
      }
    }
  }

  void _playAlarm() async {
    if (_isAlarmPlaying) return;

    try {
      await _audioPlayer.play(AssetSource('sounds/alarm2.mp3'));
      setState(() {
        _isAlarmPlaying = true;
      });
    } catch (e) {
      debugPrint('Lỗi phát âm thanh: $e');
    }
  }

  void _stopAlarm() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isAlarmPlaying = false;
      });
    } catch (e) {
      debugPrint('Lỗi dừng âm thanh: $e');
    }
  }

  @override
  void dispose() {
    _detectionTimer?.cancel();
    _controller?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phát hiện buồn ngủ'), centerTitle: true),
      body: Column(
        children: [
          Expanded(child: _buildCameraPreview()),
          _buildStatusIndicator(),
          if (_showRetryButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _initializeCamera,
                child: const Text('Thử lại'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (!_cameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(_controller!),
        ..._boxes.map(_buildDetectionBox).toList(),
      ],
    );
  }

  Widget _buildDetectionBox(DetectionBox box) {
    return Positioned(
      left: box.x,
      top: box.y,
      child: Container(
        width: box.width,
        height: box.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: box.label == 'drowsy' ? Colors.red : Colors.green,
            width: 2,
          ),
        ),
        child: Text(
          '${box.label} ${(box.confidence * 100).toStringAsFixed(1)}%',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            backgroundColor: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    Color statusColor = Colors.black;
    IconData statusIcon = Icons.info;

    if (_status.contains('Lỗi')) {
      statusColor = Colors.red;
      statusIcon = Icons.error;
    } else if (_status.contains('Buồn ngủ')) {
      statusColor = Colors.orange;
      statusIcon = Icons.warning;
    } else if (_status.contains('Bình thường')) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      color: statusColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(statusIcon, color: statusColor),
          const SizedBox(width: 8),
          Text(
            _status,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}
