import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {OnboardingScreen.routeName: (_) => OnboardingScreen()},
      initialRoute: OnboardingScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
