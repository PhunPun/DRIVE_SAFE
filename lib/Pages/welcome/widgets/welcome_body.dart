import 'package:drive_safe/apps/colors/colors.dart';
import 'package:drive_safe/apps/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/DRIVESAFE.svg'
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'TỈNH TÁO MỌI NẺO ĐƯỜNG',
                    style: TextStyle(
                      color: const Color(MyColor.white),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  height: 1,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color(MyColor.white)
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(RouterName.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(MyColor.button),
                    minimumSize: Size(259, 59)
                  ),
                  child: Text(
                    'ĐĂNG NHẬP',
                    style: TextStyle(
                      color: Color(MyColor.white),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    //TODO: dieu huong
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(MyColor.button),
                    minimumSize: Size(259, 59),
                  ),
                  child: Text(
                    'ĐĂNG KÍ',
                    style: TextStyle(
                      color: Color(MyColor.white),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}