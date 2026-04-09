import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/firebase_service.dart';
import 'package:movies/model/user_model.dart';
import 'package:movies/widgets/defaulte_botton.dart';
import 'package:provider/provider.dart';

import '../../auth/login_screen.dart';
import '../../providers/user_provider.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).currentUser!;
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
                backgroundImage: AssetImage(currentUser.avatar),
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
              currentUser.name,
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
                  onPressed: () => FirebaseService.logout().then((_) {
                    Navigator.pushReplacementNamed(
                      context,
                      LoginScreen.routeName,
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
