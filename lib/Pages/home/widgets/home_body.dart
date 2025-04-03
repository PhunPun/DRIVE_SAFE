import 'package:drive_safe/apps/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _isPress = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Image.asset(
              'assets/images/avatar.png',
              width: 120, 
              height: 120,
            ),
            const SizedBox(height: 20),
            Text(
              _isPress ? 'Sử dụng khuôn mặt này' : 'Ngắt kết nối',
              style: AppTextStyles.title(isDarkMode), 
            ),
            const SizedBox(height: 80),
            InkWell(
              onTap: () {
                setState(() {
                  _isPress = !_isPress;
                });
              },
              child: Image.asset(
                _isPress 
                    ? 'assets/images/btn_start.png' 
                    : 'assets/images/btn_stop.png',
                width: 125,
                height: 125,
              ),
            ),
          ],
        ),
      ],
    );
  }
}