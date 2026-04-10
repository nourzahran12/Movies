import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/app_theme.dart';

class SimilarItem extends StatelessWidget {
  final String url;
  final String rate;

  const SimilarItem({
    super.key,
    required this.url,
    required this.rate,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              url,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },


              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/placeholder.png",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),


          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: AppTheme.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    rate,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppTheme.white),
                  ),
                  const SizedBox(width: 5),
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