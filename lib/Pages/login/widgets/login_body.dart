import 'package:drive_safe/apps/theme/theme.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';
import 'package:drive_safe/apps/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/DRIVESAFE.svg',
          ),
          const SizedBox(height: 30),

          Text(
            'Nhập email và mật khẩu để đăng nhập',
            style: AppTextStyles.miniText(isDarkMode),
          ),
          const SizedBox(height: 5),

          _buildTextField(context, hintText: 'Email'),
          const SizedBox(height: 10),

          _buildTextField(context, hintText: 'Mật khẩu', obscureText: true),
          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Email hoặc mật khẩu không đúng!',
                style: AppTextStyles.warningText(),
              ),
              Text(
                'Quên mật khẩu?',
                style: AppTextStyles.resetPassText(),
              ),
            ],
          ),
          const SizedBox(height: 5),

          ElevatedButton(
            onPressed: () {},
            style: ButtonStyles.buttonOne(isDarkMode),
            child: Text(
              'ĐĂNG NHẬP',
              style: AppTextStyles.textButton(isDarkMode),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            height: 1,
            width: 340,
            color: isDarkMode ? MyColor.blued : MyColor.blueDark,
          ),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkMode ? MyColor.darkCard : MyColor.white,
              minimumSize: const Size(300, 40),
            ),
            child: Text(
              'Đăng nhập bằng Google',
              style: AppTextStyles.google(isDarkMode),
            ),
          ),
          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chưa có tài khoản?',
                style: AppTextStyles.menuItem(isDarkMode),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  context.goNamed(RouterName.register);
                },
                child: Text(
                  'Đăng kí',
                  style: AppTextStyles.menuItem(isDarkMode).copyWith(color: Colors.blue),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required String hintText, bool obscureText = false}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 49),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.hintText(isDarkMode),
          filled: true,
          fillColor: isDarkMode ? MyColor.darkCard : MyColor.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(33),
            borderSide: BorderSide(
              color: isDarkMode ? MyColor.darkText : MyColor.grey,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(33),
            borderSide: BorderSide(
              color: isDarkMode ? MyColor.darkText : MyColor.grey,
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
