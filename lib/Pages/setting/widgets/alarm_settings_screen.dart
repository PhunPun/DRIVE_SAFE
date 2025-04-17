import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class AlarmSettingsScreen extends StatefulWidget {
  const AlarmSettingsScreen({super.key});

  @override
  State<AlarmSettingsScreen> createState() => _AlarmSettingsScreenState();
}

class _AlarmSettingsScreenState extends State<AlarmSettingsScreen> {
  String _selectedSound = 'alarm1.mp3';
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, String>> _soundOptions = [
    {'file': 'alarm1.mp3', 'name': 'Cảnh báo 1'},
    {'file': 'alarm2.mp3', 'name': 'Cảnh báo 2'},
    {'file': 'alarm3.mp3', 'name': 'Cảnh báo 3'},
    {'file': 'alarm4.mp3', 'name': 'Cảnh báo 4'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedSound();
  }

  Future<void> _loadSelectedSound() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedSound = prefs.getString('selected_alarm') ?? 'alarm1.mp3';
    });
  }

  Future<void> _saveAndPlaySelectedSound(String sound) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_alarm', sound);
    setState(() {
      _selectedSound = sound;
    });

    // Phát thử âm thanh được chọn
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/$sound'));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã chọn: $sound')),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chọn âm thanh cảnh báo')),
      body: ListView.builder(
        itemCount: _soundOptions.length,
        itemBuilder: (context, index) {
          final option = _soundOptions[index];
          return RadioListTile<String>(
            title: Text(option['name']!),
            value: option['file']!,
            groupValue: _selectedSound,
            onChanged: (value) {
              if (value != null) _saveAndPlaySelectedSound(value);
            },
          );
        },
      ),
    );
  }
}
