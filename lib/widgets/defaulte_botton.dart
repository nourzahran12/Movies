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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBotton,
          foregroundColor: textColor,
          side: BorderSide(color: AppTheme.primary, width: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            text,
            style: TextTheme.of(
              context,
            ).titleMedium!.copyWith(color: textColor, fontWeight: .w600),
          ),
        ),
      ),
    );
  }
}
