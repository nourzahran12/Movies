import 'package:flutter/material.dart';

import '../widgets/default_text_form_field.dart';
import '../widgets/defaulte_botton.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          child: Icon(Icons.arrow_back),
        ),
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Image.asset('assets/images/forgot-password.png'),
            DefaultTextFormField(
              hintText: 'Email',
              prefixIconImageName: 'email',
            ),
            SizedBox(height: 24),
            DefaulteBotton(text: 'Verify Email', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
