import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/OnBoarding';
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> ImagesName = [
    'OnBoarding_1',
    'OnBoarding_2',
    'OnBoarding_3',
    'OnBoarding_4',
    'OnBoarding_5',
    'OnBoarding_5',
  ];
  List<String> title = [
    'Find Your Next Favorite Movie Here',
    'Discover Movies',
    'Explore All Genres',
    'Create Watchlists',
    'Rate, Review, and Learn',
  ];
  List<String> description = [
    'Get access to a huge library of movies to suit all tastes. You will surely like it.',
    'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    'Share your thoughts on the movies youve watched. Dive deep into film details and help others discover great movies with your reviews.',
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/${ImagesName[index]}.png'),
          ),
        ),
        child: Text('data'),
      ),
    );
  }
}
