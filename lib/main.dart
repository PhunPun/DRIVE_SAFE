import 'package:camera/camera.dart';
import 'package:drive_safe/apps/theme/providers/camera_provider.dart';
import 'package:drive_safe/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';
import 'apps/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late List<CameraDescription> cameras;
void main() async {
  try {
    await ApiService.checkConnection();
    print('kết nối thành công');
  } catch(e){
    print('Lỗi kết nối: $e');
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  // ✅ Dùng camera trước (front camera)
  final frontCamera = cameras.firstWhere(
    (camera) => camera.lensDirection == CameraLensDirection.front,
    orElse: () => throw Exception('Không tìm thấy camera trước'),
  );  
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => CameraProvider()..setCamera(frontCamera)),
    ],
    child: const MyApp(),
  ),
);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme,
      routerConfig: RouterCustum.router, 
    );
  }
}