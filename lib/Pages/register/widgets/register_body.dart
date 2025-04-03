import 'package:drive_safe/apps/theme/theme.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';
import 'package:drive_safe/apps/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/DRIVESAFE.svg',
          ),
          const SizedBox(height: 10),
          Text(
            'Tạo tài khoản mới',
            style: AppTextStyles.title(isDarkMode),
          ),
          const SizedBox(height: 5),
          Text(
            'Điền thông tin bên dưới để tạo tài khoản',
            style: AppTextStyles.miniText(isDarkMode),
          ),
          const SizedBox(height: 5),
          _buildTextField(context, hintText: 'Họ và tên'),
          _buildTextField(context, hintText: 'Email'),
          _buildTextField(context, hintText: 'Mật khẩu', obscureText: true),
          _buildTextField(context, hintText: 'Nhập lại mật khẩu', obscureText: true),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyles.buttonOne(isDarkMode),
            
            child: Text(
              'Đăng ký',
              style: AppTextStyles.textButton(isDarkMode),
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 10),
            height: 2,
            width: 340,
            color: isDarkMode ? MyColor.darkCard : MyColor.button,
          ),
          const SizedBox(height: 5,),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkMode ? MyColor.darkCard : MyColor.white,
              minimumSize: const Size(300, 40),
            ),
            child: Text(
              'Đăng ký bằng Google',
              style: AppTextStyles.google(isDarkMode),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đã có tài khoản?',
                style: AppTextStyles.miniText(isDarkMode),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  context.goNamed(RouterName.login);
                },
                child: Text(
                  'Đăng nhập',
                  style: AppTextStyles.resetPassText(),
                ),
              ),
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
      margin: const EdgeInsets.symmetric(horizontal: 49, vertical: 5),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.hintText(isDarkMode),
          filled: true,
          fillColor: isDarkMode ? MyColor.darkCard : MyColor.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(33),
            borderSide: BorderSide(
              color: isDarkMode ? MyColor.darkText : MyColor.blued,
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