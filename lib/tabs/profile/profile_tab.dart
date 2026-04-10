import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/tabs/profile/profile_header.dart';
import 'package:movies/tabs/profile/profile_tabs.dart';
import 'package:movies/tabs/profile/wishlistTabs.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Column(
      children: [
        ProfileHeader(),
        Expanded(child: WatchHistoryTabs()),
      ],
    );
  }
}
