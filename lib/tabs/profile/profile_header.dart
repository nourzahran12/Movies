import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/widgets/defaulte_botton.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.darkGray),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_image.png'),
              ),
              Column(
                children: [
                  Text("12", style: textTheme.headlineSmall),
                  Text("Wish List", style: textTheme.titleLarge),
                ],
              ),
              Column(
                children: [
                  Text("10", style: textTheme.headlineSmall),
                  Text("History", style: textTheme.titleLarge),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "John Safwat",
              style: textTheme.titleMedium!.copyWith(fontWeight: .w700),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: DefaulteBotton(text: 'Edit Profile', onPressed: () {}),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: DefaulteBotton(
                  text: 'Exit',
                  textColor: AppTheme.white,
                  suffixIconImageName: 'exit',
                  colorBotton: AppTheme.red,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
