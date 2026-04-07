import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/app_theme.dart';

class SimilarItem extends StatelessWidget {
  String url;
  String rate;
  SimilarItem({required this.url, required this.rate});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Positioned.fill(child: Image.network(url, fit: BoxFit.cover)),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    rate,
                    style: TextTheme.of(
                      context,
                    ).titleSmall!.copyWith(color: AppTheme.white),
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    height: 15,
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
