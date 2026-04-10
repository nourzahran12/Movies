import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/firebase_service.dart';
import 'package:movies/home_screen.dart';
import 'package:movies/widgets/avatar_picker.dart';
import 'package:movies/widgets/defaulte_botton.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../ui_utils.dart';
import '../widgets/default_text_form_field.dart';
import '../widgets/language_switcher.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isEnglish = true;
  TextEditingController nameController = .new();
  TextEditingController emailController = .new();
  TextEditingController passwordController = .new();
  TextEditingController confirmPasswordController = .new();
  TextEditingController phoneController = .new();
  GlobalKey<FormState> formKey = .new();
  String selectedAvatar = '';

  @override
  void initState() {
    super.initState();
    selectedAvatar = 'assets/images/avatar_1.png';
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          child: Icon(Icons.arrow_back),
        ),
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                AvatarPicker(
                  onChanged: (avatar) {
                    selectedAvatar = avatar;
                  },
                ),
                Text(
                  'Avatar',
                  style: textTheme.titleSmall!.copyWith(color: AppTheme.white),
                ),
                SizedBox(height: 12),
                DefaultTextFormField(
                  hintText: 'Name',
                  prefixIconImageName: 'name_user',
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: nameController,
                ),
                SizedBox(height: 24),
                DefaultTextFormField(
                  hintText: 'Email',
                  prefixIconImageName: 'email',
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                SizedBox(height: 24),
                DefaultTextFormField(
                  hintText: 'Password',
                  prefixIconImageName: 'password',
                  isPassword: true,
                  validator: (value) {
                    if (value!.isEmpty || value.contains('@')) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  controller: passwordController,
                ),
                SizedBox(height: 24),
                DefaultTextFormField(
                  hintText: 'Confirm Password',
                  prefixIconImageName: 'password',
                  isPassword: true,
                  validator: (value) {
                    if (value!.isEmpty || value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
                ),
                SizedBox(height: 24),
                DefaultTextFormField(
                  hintText: 'Phone Number',
                  prefixIconImageName: 'phone',
                  validator: (value) {
                    if (value!.isEmpty || value.length < 11) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  controller: phoneController,
                ),
                SizedBox(height: 24),
                DefaulteBotton(text: 'Create Account', onPressed: register),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: textTheme.labelLarge!.copyWith(fontWeight: .w400),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                      child: Text(
                        'Login',
                        style: textTheme.labelLarge!.copyWith(
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                LanguageSwitcher(
                  isEnglish: isEnglish,
                  onChanged: (value) {
                    isEnglish = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseService.register(
            name: nameController.text,
            phone: phoneController.text,
            email: emailController.text,
            password: passwordController.text,
            avatar: selectedAvatar,
          )
          .then((user) {
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).updateCurrentUser(user);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          })
          .catchError((error) {
            String? errorMessage;
            if (error is FirebaseAuthException) {
              errorMessage = error.message;
            }
            UIUtils.showErrorMessage(errorMessage);
          });
    }
  }
}
