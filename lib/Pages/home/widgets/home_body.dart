import 'package:drive_safe/apps/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
  
}

class _HomeBodyState extends State<HomeBody> {
  bool _ispress = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60,),
            Image.asset(
              'assets/images/avatar.png'
            ),
            const SizedBox(height: 20,),
            Text(
              _ispress
              ? 'Sử dụng khuông mặt này'
              : 'Ngắt kết nối',
              style: TextStyle(
                color: Color(MyColor.black),
                fontSize: 16,
                fontWeight: FontWeight.bold              
              ),
            ),
            const SizedBox(height: 80,),
            InkWell(
              onTap: () {
                setState(() {
                  _ispress =!_ispress;
                });
              },
              child: Image.asset(
                _ispress 
                ? 'assets/images/btn_start.png' 
                : 'assets/images/btn_stop.png',
                width: 125,
                height: 125,
              ),
            )
          ],
        )
      ],
    );
  }
}