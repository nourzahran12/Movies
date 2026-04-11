import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/forgot_password_screen.dart';
import 'package:movies/auth/login_screen.dart';
import 'package:movies/auth/register_screen.dart';
import 'package:movies/home_screen.dart';
import 'package:movies/onboarding_screen.dart';
import 'package:movies/providers/movies_details_provider.dart';
import 'package:movies/providers/user_provider.dart';
import 'package:movies/providers/watch_history_provider.dart';
import 'package:movies/start_screen.dart';
import 'package:movies/tabs/profile/edit_profile.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MovieDetailsPorvider()),
        ChangeNotifierProvider(create: (_) => WatchHistory()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (_) => StartScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        EditProfile.routeName: (_) => EditProfile(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
