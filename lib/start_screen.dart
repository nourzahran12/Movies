import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/providers/movies_details_provider.dart';
import 'package:movies/providers/watch_history_provider.dart';
import 'package:movies/shared_prefs_helper.dart';
import 'package:movies/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../firebase_service.dart';
import '../model/user_model.dart';
import '../providers/user_provider.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = '/start';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    bool seenOnboarding = await SharedPrefsHelper.isOnboardingSeen();
    if (!seenOnboarding) {
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
      return;
    }
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      UserModel user = await FirebaseService.getUser(firebaseUser.uid);
      Provider.of<UserProvider>(context, listen: false).updateCurrentUser(user);
      Provider.of<MovieDetailsPorvider>(
        context,
        listen: false,
      ).favouriteMoviesList = user.wishlist ?? [];
      Provider.of<WatchHistory>(context, listen: false).watchHistoryMoviesList =
          user.history ?? [];
      Provider.of<MovieDetailsPorvider>(
        context,
        listen: false,
      ).notifyListeners();

      Provider.of<WatchHistory>(context, listen: false).notifyListeners();

      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: LoadingIndicator()));
  }
}
