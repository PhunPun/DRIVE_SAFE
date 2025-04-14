import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraProvider with ChangeNotifier {
  late CameraDescription _camera;

  CameraDescription get camera => _camera;

  void setCamera(CameraDescription cam) {
    _camera = cam;
    notifyListeners();
  }
}