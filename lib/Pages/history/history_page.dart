import 'dart:ui';
import 'package:drive_safe/Pages/history/widgets/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:drive_safe/apps/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
Widget build(BuildContext context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: Provider.of<ThemeProvider>(context).backgroundGradient,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.history, size: 42, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    'Lịch Sử',
                    style: AppTextStyles.title(isDarkMode),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Time()
                          )
                        );
                      },
                      child: _buildHistoryItem(
                        iconPath: 'assets/icons/time.svg',
                        title: 'Chi tiết thời gian',
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    _buildHistoryItem(
                      iconPath: 'assets/icons/alert.svg',
                      title: 'Tần suất cảnh báo',
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildHistoryItem({required String iconPath, required String title, required bool isDarkMode}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    decoration: BoxDecoration(
      color: isDarkMode ? MyColor.darkCard : Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 3),
        )
      ],
    ),
    child: Row(
      children: [
        SvgPicture.asset(iconPath, width: 40, height: 40),
        const SizedBox(width: 15),
        Text(
          title,
          style: AppTextStyles.settingButton(isDarkMode),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
      ],
    ),
  );
}
}