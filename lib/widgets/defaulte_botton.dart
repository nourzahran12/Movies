import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/app_theme.dart';

class DefaulteBotton extends StatelessWidget {
  String text;
  Color textColor;
  Color colorBotton;
  double border;
  VoidCallback onPressed;
  String? iconName;

  DefaulteBotton({
    required this.text,
    required this.onPressed,
    this.textColor = AppTheme.black,
    this.colorBotton = AppTheme.primary,
    this.border = 0,
    this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBotton,
          foregroundColor: textColor,
          side: border == 0
              ? null
              : BorderSide(color: AppTheme.primary, width: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: iconName == null
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  text,
                  style: TextTheme.of(
                    context,
                  ).titleMedium!.copyWith(color: textColor, fontWeight: .w400),
                ),
              )
            : Row(
                mainAxisAlignment: .center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/$iconName.svg',
                    width: 32,
                    height: 32,
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      text,
                      style: TextTheme.of(context).titleMedium!.copyWith(
                        color: textColor,
                        fontWeight: .w400,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
