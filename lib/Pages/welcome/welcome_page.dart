import 'package:drive_safe/Pages/welcome/widgets/welcome_body.dart';
import 'package:drive_safe/Pages/welcome/widgets/welcome_footer.dart';
import 'package:drive_safe/Pages/welcome/widgets/welcome_header.dart';
import 'package:drive_safe/apps/theme/theme.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final backgroundGradient = isDarkMode ? appGradientDark : appGradientLight;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WelcomeHeader(),
                WelcomeBody(),
                WelcomeFooter(),
              ],
            ),
          )
        ],
      ),
    );
  }
}