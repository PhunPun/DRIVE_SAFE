import 'package:drive_safe/Pages/register/widgets/register_body.dart';
import 'package:drive_safe/Pages/register/widgets/register_header.dart';
import 'package:drive_safe/apps/theme/theme.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
              children: [
                RegisterHeader(),
                RegisterBody()
              ],
            ),
          )
        ],
      ),
    );
  }
}