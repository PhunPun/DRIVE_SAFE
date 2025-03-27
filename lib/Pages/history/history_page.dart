import 'package:drive_safe/apps/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.history,
              size: 42,
              color: Color(MyColor.white),
            ),
            const SizedBox(width: 10,),
            Text(
              'Lịch sử',
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
              'assets/icons/time.svg',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15,),
            Text(
              'Chi tiết thời gian',
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
              'assets/icons/loa.svg',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15,),
            Text(
              'Tần suất cảnh báo',
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