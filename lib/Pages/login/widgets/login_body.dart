import 'package:drive_safe/apps/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/DRIVESAFE.svg',
          ),
          const SizedBox(height: 30),
          Text(
            'Nhập email và password để đăng nhập',
            style: TextStyle(
              color: const Color(MyColor.white),
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity, 
            margin: EdgeInsets.symmetric(horizontal: 49),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Color(0xFFC9D6DF)
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(
                    color: Color(0xFF6499E9),
                    width: 1,
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(
                    color: Color(0xFF52616B),
                    width: 0.5,
                  )
                )
              ),
            ),
          ),
          Container(
            width: double.infinity, 
            margin: EdgeInsets.only(top: 10, right: 49, left: 49),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Color(0xFFC9D6DF)
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(
                    color: Color(0xFF6499E9),
                    width: 1,
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(
                    color: Color(0xFF52616B),
                    width: 0.5,
                  )
                )
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Email hoặc mật khẩu không đúng!',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(MyColor.red)
                ),
              ),
              Text(
                'Quên mật khẩu?',
                style: TextStyle(
                  color: Color(MyColor.blued),
                  fontSize: 11,
                ),
              )
            ],
          ),
          const SizedBox(height: 5,),
          ElevatedButton(
            onPressed: () {
              //TODO: điều hướng
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(MyColor.button),
              minimumSize: Size(232, 41)
            ),
            child: Text(
              'ĐĂNG NHẬP',
              style: TextStyle(
                color: Color(MyColor.white),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            width: 300,
            color: Color(MyColor.button),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              //TODO: điều hướng
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(MyColor.white),
              minimumSize: Size(300, 40),
            ),
            child: Text(
              'Đăng nhập bằng Google',
              style: TextStyle(
                color: Color(MyColor.black),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chưa có tài khoản?',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(MyColor.black)
                ),
              ),
              const SizedBox(width: 10,),
              Text(
                'Đăng kí',
                style: TextStyle(
                  color: Color(MyColor.blued),
                  fontSize: 11,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
