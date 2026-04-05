import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/widgets/avatar_picker.dart';
import 'package:movies/widgets/defaulte_botton.dart';

import '../widgets/default_text_form_field.dart';
import '../widgets/language_switcher.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isEnglish = true;

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
          child: Column(
            children: <Widget>[
              AvatarPicker(),
              Text(
                'Avatar',
                style: textTheme.titleSmall!.copyWith(color: AppTheme.white),
              ),
              SizedBox(height: 12),
              DefaultTextFormField(
                hintText: 'Name',
                prefixIconImageName: 'name_user',
              ),
              SizedBox(height: 24),
              DefaultTextFormField(
                hintText: 'Email',
                prefixIconImageName: 'email',
              ),
              SizedBox(height: 24),
              DefaultTextFormField(
                hintText: 'Password',
                prefixIconImageName: 'password',
                isPassword: true,
              ),
              SizedBox(height: 24),
              DefaultTextFormField(
                hintText: 'Confirm Password',
                prefixIconImageName: 'password',
                isPassword: true,
              ),
              SizedBox(height: 24),
              DefaultTextFormField(
                hintText: 'Phone Number',
                prefixIconImageName: 'phone',
              ),
              SizedBox(height: 24),
              DefaulteBotton(text: 'Create Account', onPressed: () {}),
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
    );
  }
}
