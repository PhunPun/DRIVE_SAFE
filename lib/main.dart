import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';
import 'apps/router/router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
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