import 'package:drive_safe/Pages/welcome/widgets/welcome_body.dart';
import 'package:drive_safe/Pages/welcome/widgets/welcome_footer.dart';
import 'package:drive_safe/Pages/welcome/widgets/welcome_header.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF018ABE),  
                  Color(0xFFFFFFFF),  
                ]
              )
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WelcomeHeader(),
                WelcomeBody(),
                WelcomeFooter()
              ],
            ),
          )
        ],
      ),
    );
  }
}