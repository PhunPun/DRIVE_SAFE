import 'package:flutter/material.dart';

class MyColor {
  // Màu cho Light Mode
  static const Color white = Color(0xFFFFFFFF);
  static const Color button = Color(0xFF018ABE);
  static const Color grey = Color(0xFFCACACA);
  static const Color lightRed = Color(0xFFF291A1);
  static const Color black = Color(0xFF000000);
  static const Color blueDark = Color(0xFF0C4BD1);
  static const Color red = Color(0xFFFF0000);
  static const Color blued = Color(0xFF0000FF);

  // Màu cho Dark Mode
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFE0E0E0);
}

class AppTextStyles {
  static TextStyle title(bool isDarkMode) => TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? MyColor.darkText : MyColor.white,
      );

  static TextStyle textButton(bool isDarkMode) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? MyColor.black : MyColor.white,
      );

  static TextStyle menuItem(bool isDarkMode) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? MyColor.darkText : MyColor.black,
      );

  static TextStyle hintText(bool isDarkMode) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: MyColor.grey,
      );

  static TextStyle warningText() => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: MyColor.red,
      );

  static TextStyle resetPassText() => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: MyColor.blueDark,
      );

  static TextStyle miniText(bool isDarkMode) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: isDarkMode ? MyColor.darkText : MyColor.black,
      );

  static TextStyle google(bool isDarkMode) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? MyColor.darkText : MyColor.black,
      );

  static TextStyle textLogo(bool isDarkMode) => TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? MyColor.darkText : MyColor.white,
      );

  static TextStyle settingButton(bool isDarkMode) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? MyColor.darkText : MyColor.black,
      );
}

class ButtonStyles {
  static ButtonStyle buttonOne(bool isDarkMode) {
    return ElevatedButton.styleFrom(
      backgroundColor: isDarkMode ? MyColor.white: MyColor.button,
      minimumSize: const Size(200, 50),
    );
  }
}

const LinearGradient appGradientLight = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF018ABE), Color(0xFFFFFFFF)],
);

const LinearGradient appGradientDark = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF018ABE),Color(0xFF121212)],
);

final ThemeData lightTheme = ThemeData(
  fontFamily: 'RobotoSlap',
  brightness: Brightness.light,
  primaryColor: MyColor.button,
  scaffoldBackgroundColor: MyColor.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColor.button,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
);

final ThemeData darkTheme = ThemeData(
  fontFamily: 'RobotoSlap',
  brightness: Brightness.dark,
  primaryColor: MyColor.darkBackground,
  scaffoldBackgroundColor: MyColor.darkBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColor.darkBackground,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
);
