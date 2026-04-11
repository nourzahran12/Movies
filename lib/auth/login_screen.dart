import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/google_sign_in_service.dart';
import 'package:movies/firebase_service.dart';
import 'package:movies/widgets/default_text_form_field.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';
import '../model/user_model.dart';
import '../providers/user_provider.dart';
import '../ui_utils.dart';
import '../widgets/defaulte_botton.dart';
import '../widgets/detault_text_botton.dart';
import '../widgets/language_switcher.dart';
import '../widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isEnglish = true;
  TextEditingController emailController = .new();
  TextEditingController passwordController = .new();
  GlobalKey<FormState> formKey = .new();
  final googleService = GoogleSignInService();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double lineWidth = MediaQuery.sizeOf(context).width * 0.25;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
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
                          style: textTheme.labelLarge!.copyWith(
                            fontWeight: .w400,
                          ),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/register',
                            );
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
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          final success = await googleService
                              .signInWithGoogle();
                          if (!success) return;

                          final firebaseUser =
                              FirebaseAuth.instance.currentUser;
                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).updateCurrentUser(
                            UserModel(
                              id: firebaseUser?.uid ?? '',
                              name: firebaseUser?.displayName ?? '',
                              avatar: firebaseUser?.photoURL ?? '',
                              email: firebaseUser?.email ?? '',
                              phone: firebaseUser?.phoneNumber ?? '',
                              wishlist: [],
                              history: [],
                            ),
                          );
                          if (!context.mounted) return;
                          UIUtils.showSuccessMessage('Login Successfully');
                          Navigator.pushReplacementNamed(
                            context,
                            HomeScreen.routeName,
                          );
                        } catch (error) {
                          UIUtils.showErrorMessage(error.toString());
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
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
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(child: LoadingIndicator()),
            ),
        ],
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      FirebaseService.login(
            email: emailController.text,
            password: passwordController.text,
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
