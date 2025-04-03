import 'package:drive_safe/Pages/login/widgets/login_body.dart';
import 'package:drive_safe/Pages/login/widgets/login_header.dart';
import 'package:drive_safe/apps/theme/theme.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeProvider.isDarkMode 
          ? MyColor.darkBackground 
          : MyColor.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: themeProvider.backgroundGradient,
            ),
          ),
          SafeArea(
            child: Column(
              children: const [
                LoginHeader(),
                LoginBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
