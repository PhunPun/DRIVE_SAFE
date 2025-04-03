import 'package:drive_safe/apps/theme/theme.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';
import 'package:drive_safe/apps/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/DRIVESAFE.svg',
                  width: 300,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    'TỈNH TÁO MỌI NẺO ĐƯỜNG',
                    style: AppTextStyles.title(isDarkMode),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  height: 1,
                  width: 340,
                  decoration: BoxDecoration(
                    color: isDarkMode ? MyColor.darkCard : MyColor.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(RouterName.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.button,
                    minimumSize: const Size(259, 59),
                  ),
                  child: Text(
                    'ĐĂNG NHẬP',
                    style: AppTextStyles.textButton(isDarkMode),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(RouterName.register);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.button,
                    minimumSize: const Size(259, 59),
                  ),
                  child: Text(
                    'ĐĂNG KÍ',
                    style: AppTextStyles.textButton(isDarkMode),
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