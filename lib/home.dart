import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/tabs/browse.dart';
import 'package:movies/tabs/home.dart';
import 'package:movies/tabs/search.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int curruntIndex = 0;
  final List<Widget>Taps=[
    HomeTab(),
    Search(),
    Browse(),
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: curruntIndex,
        onTap: (index) {
          curruntIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assetsicons/home.svg'),
            activeIcon: SvgPicture.asset('assets/icons/home-Filled.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/seach.svg'),
            activeIcon: SvgPicture.asset('assets/icons/seach-filled.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/explore.svg'),
            activeIcon: SvgPicture.asset('assets/icons/explore-filled.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/Profile.svg'),
            activeIcon: SvgPicture.asset('assets/icons/Profile-filled.svg'),
          ),
        ],
      ),
    );
  }
}
