import 'package:flutter/material.dart';
import 'package:test_project/app/themes/app_color.dart';

class AppTheme {
  static final appTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Epilogue',
    primaryColor: MaterialColor(0xFFFFFFFF, <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFAFAFA),
      200: Color(0xFFF5F5F5),
      300: Color(0xFFF0F0F0),
      400: Color(0xFFEDEDED),
      500: Color(0xFFE0E0E0),
      600: Color(0xFFDBDBDB),
      700: Color(0xFFC7C7C7),
      800: Color(0xFFB3B3B3),
      900: Color(0xFF9E9E9E),
    }),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
  );
}
