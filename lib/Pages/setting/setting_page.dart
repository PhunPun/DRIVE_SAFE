import 'package:drive_safe/Pages/setting/widgets/alarm_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:drive_safe/apps/theme/theme.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeProvider.isDarkMode 
          ? MyColor.darkBackground 
          : MyColor.white,
      body: Stack( 
        children: [
          Container(
              decoration: BoxDecoration(
              gradient: themeProvider.backgroundGradient,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề
                  Row(
                    children: [
                      Icon(Icons.settings, size: 42, color: isDarkMode ? MyColor.white : MyColor.black),
                      const SizedBox(width: 10),
                      Text(
                        'Cài đặt',
                        style: TextStyle(
                          fontSize: 32,
                          color: isDarkMode ? MyColor.white : MyColor.black,
                          fontWeight: FontWeight.w600,
                        ),
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
                                  builder: (context) => AlarmSettingsScreen(),
                              ),
                            );
                          },
                          child: _buildSettingItem(
                            context,
                            iconPath: 'assets/icons/music.svg',
                            title: 'Âm thanh cảnh báo',
                          ),
                        ),
                        _buildSettingItem(
                          context,
                          iconPath: 'assets/icons/dark.svg',
                          title: 'Chế độ ban đêm',
                          trailing: Switch(
                            value: isDarkMode,
                            onChanged: (bool value) {
                              themeProvider.toggleTheme(value);
                            },
                          ),
                        ),
                        _buildSettingItem(
                          context,
                          iconPath: 'assets/icons/vuong.svg',
                          title: 'Mức độ nhận diện',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required String iconPath,
    required String title,
    Widget? trailing,
  }) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? MyColor.darkCard : MyColor.white,
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
          SvgPicture.asset(iconPath, width: 40, height: 40, color: isDarkMode ? MyColor.white : MyColor.black,),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: isDarkMode ? MyColor.white : MyColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}