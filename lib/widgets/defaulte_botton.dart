import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';

class DefaulteBotton extends StatelessWidget {
  String text;
  Color textColor;
  Color colorBotton;
  double border;
  VoidCallback onPressed;

  DefaulteBotton({
    required this.text,
    required this.onPressed,
    this.textColor = AppTheme.black,
    this.colorBotton = AppTheme.primary,
    this.border = 0,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorBotton,
        foregroundColor: textColor,
        side: BorderSide(color: AppTheme.primary, width: border),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextTheme.of(context).titleMedium),
    );
  }
}
