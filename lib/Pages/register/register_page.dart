import 'package:drive_safe/Pages/register/widgets/register_body.dart';
import 'package:drive_safe/Pages/register/widgets/register_header.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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