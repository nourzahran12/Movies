
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/forgot_password_screen.dart';
import 'package:movies/auth/login_screen.dart';
import 'package:movies/auth/register_screen.dart';
import 'package:movies/home_screen.dart';
import 'package:movies/onboarding_screen.dart';
import 'package:movies/providers/History%20Provider.dart';
import 'package:movies/providers/Movies%20Details%20Provider.dart';
import 'package:movies/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final bool showOnboarding = prefs.getBool('showOnboarding') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MovieDetails()),
        ChangeNotifierProvider(create: (_) => WatchHistory())

      ],
      child: MyApp(showOnboarding: showOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  MyApp({required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
      },
      initialRoute: HomeScreen
          .routeName, // showOnboarding ? OnboardingScreen.routeName : LoginScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
