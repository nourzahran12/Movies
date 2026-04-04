import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';

class BuildInfo extends StatelessWidget {
  Widget icon;
  String text;

  BuildInfo({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
      decoration: BoxDecoration(
        color: AppTheme.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: 5),
          Text(text, style: TextTheme.of(context).titleLarge),
        ],
      ),
    );
  }
}
