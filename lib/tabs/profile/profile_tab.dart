import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/tabs/profile/profile_header.dart';
import 'package:movies/tabs/profile/profile_tabs.dart';

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
        Row(
          children: [
            ProfileTabs(
              text: "Watch List",
              index: 0,
              selectedTab: selectedTab,
              iconName: 'list',
              onTap: () {
                setState(() {
                  selectedTab = 0;
                });
              },
            ),
            ProfileTabs(
              text: "History",
              index: 1,
              selectedTab: selectedTab,
              iconName: 'history',
              onTap: () {
                setState(() {
                  selectedTab = 1;
                });
              },
            ),
          ],
        ),
        Container(
          height: 3,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: selectedTab == 0
                      ? AppTheme.primary
                      : Colors.transparent,
                ),
              ),
              Expanded(
                child: Container(
                  color: selectedTab == 1
                      ? AppTheme.primary
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
