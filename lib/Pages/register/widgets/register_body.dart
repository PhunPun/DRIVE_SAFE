import 'package:drive_safe/apps/colors/colors.dart';
import 'package:drive_safe/apps/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/DRIVESAFE.svg',
        ),
        const SizedBox(height: 10),
        Text(
          'Tạo tào khoản mới',
          style: TextStyle(
            color: const Color(MyColor.white),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Điền thông tin bên dưới để tạo tài khaonr',
          style: TextStyle(
            color: const Color(MyColor.white),
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 49),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Họ và tên',
              hintStyle: TextStyle(
                color: Color(MyColor.grey)
              ),
              filled: true,
              fillColor: Color(MyColor.white),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33),
                borderSide: BorderSide(
                  color: Color(MyColor.blued),
                  width: 1
                )
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33),
                borderSide: BorderSide(
                  color: Color(MyColor.grey),
                  width: 0.5
                )
              )
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 49, right: 49),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Color(MyColor.grey)
              ),
              filled: true,
              fillColor: Color(MyColor.white),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33),
                borderSide: BorderSide(
                  color: Color(MyColor.blued),
                  width: 1
                )
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33),
                borderSide: BorderSide(
                  color: Color(MyColor.grey),
                  width: 0.5
                )
              )
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 49, right: 49),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Mật khẩu',
              hintStyle: TextStyle(
                color: Color(MyColor.grey)
              ),
              filled: true,
              fillColor: Color(MyColor.white),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33),
                borderSide: BorderSide(
                  color: Color(MyColor.blued),
                  width: 1
                )
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33),
                borderSide: BorderSide(
                  color: Color(MyColor.grey),
                  width: 0.5
                )
              )
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 49, right: 49),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Nhập lại mật khẩu',
              hintStyle: TextStyle(
                color: Color(MyColor.grey)
              ),
              filled: true,
              fillColor: Color(MyColor.white),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33),
                borderSide: BorderSide(
                  color: Color(MyColor.blued),
                  width: 1
                )
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33),
                borderSide: BorderSide(
                  color: Color(MyColor.grey),
                  width: 0.5
                )
              )
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
            minimumSize: Size(232, 41),
          ),
          child: Text(
            'Đăng ký',
            style: TextStyle(
              color: Color(MyColor.white),
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 10),
          height: 1,
          width: 340,
          decoration: BoxDecoration(
            color: Color(MyColor.button)
          ),
        ),
        ElevatedButton(
          onPressed: () {
            //TODO: dieu huong
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(MyColor.white),
            minimumSize: Size(300, 40),
          ),
          child: Text(
            'Đăng ký bằng Google',
            style: TextStyle(
              color: Color(MyColor.black),
              fontSize: 18
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Đã có tài khoản?',
              style: TextStyle(
                color: Color(MyColor.black),
                fontSize: 12
              ),
            ),
            const SizedBox(width: 10,),
            InkWell(
              onTap: () {
                context.goNamed(RouterName.login);
              },
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  color: Color(MyColor.blued),
                  fontSize: 12
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}