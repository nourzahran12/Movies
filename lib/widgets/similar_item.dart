import 'package:flutter/material.dart';

class SimilarItem extends StatelessWidget {
  String url;
  SimilarItem({required this.url});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(url, fit: BoxFit.cover),
    );
  }
}
