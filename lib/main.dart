import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/forgot_password_screen.dart';
import 'package:movies/auth/login_screen.dart';
import 'package:movies/auth/register_screen.dart';
import 'package:movies/home_screen.dart';
import 'package:movies/movies_details_screen.dart';
import 'package:movies/onboarding_screen.dart';
import 'package:movies/providers/settings_provider.dart';
import 'package:movies/providers/user_provider.dart';
import 'package:provider/provider.dart';

<<<<<<< HEAD
=======
import 'l10n/app_localizations.dart';

>>>>>>> 1975a548e7c2a87c7e8c5644ef2ccafd10e4fd81
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(create: (_) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
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
        MoviesDetailsScreen.routeName: (_) => MoviesDetailsScreen(),
      },
      initialRoute: OnboardingScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(SettingsProvider().languageCode),
    );
  }
}
