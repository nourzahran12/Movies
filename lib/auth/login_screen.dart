import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/widgets/default_text_form_field.dart';

import '../widgets/defaulte_botton.dart';
import '../widgets/detault_text_botton.dart';
import '../widgets/language_switcher.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isEnglish = true;
  TextEditingController emailController = .new();
  TextEditingController passwordController = .new();
  GlobalKey<FormState> formKey = .new();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double lineWidth = MediaQuery.sizeOf(context).width * 0.25;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset('assets/images/logo_movies.png'),
                DefaultTextFormField(
                  hintText: 'Email',
                  prefixIconImageName: 'email',
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 22),
                DefaultTextFormField(
                  hintText: 'Password',
                  prefixIconImageName: 'password',
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  isPassword: true,
                ),
                Align(
                  alignment: .centerRight,
                  child: DetaultTextBotton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/forgot_password',
                      );
                    },
                    text: 'Forgot Password?',
                  ),
                ),
                SizedBox(height: 22),
                DefaulteBotton(text: 'Login', onPressed: login),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: textTheme.labelLarge!.copyWith(fontWeight: .w400),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: Text(
                        'Create One',
                        style: textTheme.labelLarge!.copyWith(
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 27),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    SizedBox(
                      width: lineWidth,
                      child: Divider(color: AppTheme.primary),
                    ),
                    SizedBox(width: 11),
                    Text(
                      'OR',
                      style: textTheme.labelLarge!.copyWith(
                        fontWeight: .w500,
                        fontSize: 15,
                        color: AppTheme.primary,
                      ),
                    ),
                    SizedBox(width: 11),
                    SizedBox(
                      width: lineWidth,
                      child: Divider(color: AppTheme.primary),
                    ),
                  ],
                ),
                SizedBox(height: 28),
                DefaulteBotton(
                  text: 'Login With Google',
                  onPressed: () {},
                  prefixIconImageName: 'google',
                ),
                SizedBox(height: 28),
                LanguageSwitcher(
                  isEnglish: isEnglish,
                  onChanged: (value) {
                    isEnglish = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {}
  }
}
