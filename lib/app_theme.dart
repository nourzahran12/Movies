import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFF6BD00);
  static const Color black = Color(0xFF121312);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF282A28);
  static const Color lightgray = Color(0xFFADADAD);
  static const Color darkGray = Color(0xFF212121);
  static const Color red = Color(0xFFE82626);

  static ThemeData lightTheme = ThemeData();

  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    appBarTheme: AppBarThemeData(
      surfaceTintColor: Colors.transparent,
      backgroundColor: black,
      foregroundColor: primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primary,
      ),
    ),
    scaffoldBackgroundColor: black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: gray,
      selectedItemColor: white,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(fontSize: 36, fontWeight: .w500, color: white),
      titleLarge: TextStyle(fontSize: 24, fontWeight: .w700, color: white),
      titleMedium: TextStyle(fontSize: 20, fontWeight: .w400, color: white),
      titleSmall: TextStyle(fontSize: 16, fontWeight: .w400, color: black),
      labelLarge: TextStyle(fontSize: 14, fontWeight: .w900, color: white),
    ),
  );
}
