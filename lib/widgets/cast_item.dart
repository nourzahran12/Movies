import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';

class CastItem extends StatelessWidget {
  String img;
  String name;
  String character;

  CastItem({required this.img, required this.name, required this.character});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppTheme.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(img, width: 70, height: 70, fit: BoxFit.cover),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: $name", style: textTheme.titleMedium),
              Text("Character: $character", style: textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}
