import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/auth_service.dart';
import 'package:movies/widgets/defaulte_botton.dart';
import 'package:provider/provider.dart';

import '../../auth/login_screen.dart';
import '../../providers/user_provider.dart';
import '../../ui_utils.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.currentUser;
    if (currentUser == null) {
      return Center(child: CircularProgressIndicator());
    }

    TextTheme textTheme = TextTheme.of(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(color: AppTheme.darkGray),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: currentUser.avatar.startsWith('http')
                      ? NetworkImage(currentUser.avatar)
                      : AssetImage(currentUser.avatar) as ImageProvider,
                ),
                Column(
                  children: [
                    Text("12", style: textTheme.headlineSmall),
                    SizedBox(height: 12),
                    Text("Wish List", style: textTheme.titleLarge),
                  ],
                ),
                Column(
                  children: [
                    Text("10", style: textTheme.headlineSmall),
                    SizedBox(height: 12),
                    Text("History", style: textTheme.titleLarge),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                currentUser.name,
                style: textTheme.titleMedium!.copyWith(fontWeight: .w700),
              ),
            ),
            SizedBox(height: 23),
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
                    onPressed: () async {
                      try {
                        await AuthService().logout();
                      } catch (error) {
                        UIUtils.showErrorMessage(error.toString());
                      }
                      if (!context.mounted) return;
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
