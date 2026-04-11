import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/tabs/profile/widget/avatar_item.dart';
import 'package:movies/widgets/defaulte_botton.dart';
import 'package:movies/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../auth/login_screen.dart';
import '../../firebase_service.dart';
import '../../model/user_model.dart';
import '../../providers/user_provider.dart';
import '../../widgets/default_text_form_field.dart';
import '../../widgets/detault_text_botton.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = '/edit_profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int selectedIndex = 0;
  bool showAvatars = false;

  List<String> avatarList = [
    "assets/images/avatar_1.png",
    "assets/images/avatar_2.png",
    "assets/images/avatar_3.png",
    "assets/images/avatar_4.png",
    "assets/images/avatar_5.png",
    "assets/images/avatar_6.png",
    "assets/images/avatar_7.png",
    "assets/images/avatar_8.png",
    "assets/images/avatar_9.png",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final currentUser = userProvider.currentUser;
      if (currentUser != null) {
        int index = avatarList.indexOf(currentUser.avatar);
        if (index != -1) {
          setState(() {
            selectedIndex = index;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.currentUser;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text('Pick Avatar')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showAvatars = true;
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(avatarList[selectedIndex]),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DefaultTextFormField(
                  hintText: currentUser.name,
                  prefixIconImageName: 'person',
                ),
                const SizedBox(height: 20),
                DefaultTextFormField(
                  hintText: currentUser.phone,
                  prefixIconImageName: 'phone',
                ),
                const SizedBox(height: 10),
                DetaultTextBotton(text: 'Reset Password', onPressed: () {}),
                const Spacer(),
                DefaulteBotton(
                  text: 'Delete Account',
                  onPressed: () async {
                    if (currentUser == null) return;
                    try {
                      await FirebaseService.deleteUser(currentUser.id);
                      final googleSignIn = GoogleSignIn();
                      await googleSignIn.disconnect();
                      userProvider.updateCurrentUser(null);
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error deleting account")),
                      );
                    } finally {
                      LoadingIndicator();
                    }
                  },
                  colorBotton: AppTheme.red,
                  textColor: AppTheme.white,
                ),
                const SizedBox(height: 20),
                DefaulteBotton(
                  text: 'Update Data',
                  onPressed: () async {
                    if (currentUser == null) return;
                    String newAvatar = avatarList[selectedIndex];
                    UserModel updatedUser = UserModel(
                      id: currentUser.id,
                      name: currentUser.name,
                      phone: currentUser.phone,
                      email: currentUser.email,
                      avatar: newAvatar,
                      wishlist: currentUser.wishlist,
                      history: currentUser.history,
                    );
                    await FirebaseService.updateUser(updatedUser);
                    userProvider.updateCurrentUser(updatedUser);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Updated successfully")),
                    );
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        if (showAvatars)
          Positioned.fill(
            child: Container(
              color: AppTheme.black.withOpacity(0.7),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: avatarList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                showAvatars = false;
                              });
                            },
                            child: AvatarItem(
                              image: avatarList[index],
                              isSelected: selectedIndex == index,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
