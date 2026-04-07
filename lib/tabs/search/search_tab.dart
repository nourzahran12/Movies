import 'package:flutter/material.dart';
import 'package:movies/widgets/default_text_form_field.dart';
import 'package:movies/widgets/similar_item.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultTextFormField(
                hintText: 'Search',
                prefixIconImageName: 'seach',
              ),
              SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: 20,
                itemBuilder: (_, index) => SimilarItem(
                  url:
                      "https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
                  rate: '7.7',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
