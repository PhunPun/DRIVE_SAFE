import 'package:drive_safe/apps/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.settings,
              size: 42,
              color: Color(MyColor.white),
            ),
            const SizedBox(width: 10,),
            Text(
              'Cài đặt',
              style: TextStyle(
                fontSize: 32,
                color: Color(MyColor.white),
                fontWeight: FontWeight.w600
              ),
            )
          ],
        ),
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/music.svg',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15,),
            Text(
              'Âm thanh cảnh báo',
              style: TextStyle(
                fontSize: 24,
                color: Color(MyColor.black),
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        const SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/dark.svg',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15,),
            Text(
              'Chế độ ban đêm',
              style: TextStyle(
                fontSize: 24,
                color: Color(MyColor.black),
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        const SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/vuong.svg',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15,),
            Text(
              'Mức độ nhận diện',
              style: TextStyle(
                fontSize: 24,
                color: Color(MyColor.black),
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ],
    );
  }
}