import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:drive_safe/apps/theme/providers/camera_provider.dart';

class DrowsinessScreen extends StatefulWidget {
  const DrowsinessScreen({super.key});

  @override
  _DrowsinessScreenState createState() => _DrowsinessScreenState();
}

class _DrowsinessScreenState extends State<DrowsinessScreen> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  String _status = 'Initializing...';
  String _processedImage = '';
  bool _isDetecting = false;

  final String apiUrl = 'http://192.168.5.85:5000/api/detect_drowsiness';

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = Future.value();
    _initializeCamera().then((_) {
      _startAutoDetectLoop(); // 🔁 Bắt đầu kiểm tra liên tục sau khi khởi tạo camera
    });
  }

  Future<void> _initializeCamera() async {
    try {
      final CameraDescription camera = Provider.of<CameraProvider>(context, listen: false).camera;

      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;

      if (_controller!.value.isInitialized) {
        setState(() {
          _status = 'Camera initialized';
        });
      } else {
        setState(() {
          _status = 'Error: Camera failed to initialize properly';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Error initializing camera: $e';
      });
    }
  }

  void _startAutoDetectLoop() async {
    while (mounted) {
      if (!_isDetecting && _controller != null && _controller!.value.isInitialized) {
        await _detectDrowsiness();
      }
      await Future.delayed(const Duration(seconds: 5)); // Kiểm tra mỗi 5 giây
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _detectDrowsiness() async {
    if (_isDetecting || _controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      _isDetecting = true;
      _status = 'Detecting...';
      _processedImage = '';
    });

    try {
      await _initializeControllerFuture;

      if (_controller!.value.isPreviewPaused) {
        await _controller!.resumePreview();
      }

      final image = await _controller!.takePicture();
      final bytes = await File(image.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() {
          _status = result['drowsy_detected']
              ? '😴 Drowsy Detected (Confidence: ${(result['confidence'] * 100).toStringAsFixed(2)}%)'
              : '✅ No Drowsiness Detected';
          _processedImage = result['processed_image'] ?? '';
        });
      } else {
        setState(() {
          _status = 'API Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Error during detection: $e';
      });
    } finally {
      setState(() {
        _isDetecting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drowsiness Detection'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    if (_controller == null || !_controller!.value.isInitialized) {
                      return const Center(
                        child: Text(
                          'Camera not initialized',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return CameraPreview(_controller!);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                _status,
                style: TextStyle(
                  fontSize: 16,
                  color: _status.contains('Error') ? Colors.red : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (_processedImage.isNotEmpty)
              Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.memory(
                  base64Decode(_processedImage),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Error loading processed image',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
