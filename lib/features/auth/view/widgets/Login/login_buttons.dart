import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'forgot_password_button.dart';
import 'google_button.dart';
import 'login_button.dart';
import 'signup_divider.dart';
import 'signup_button.dart';

class LoginButtons extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButtons({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ForgotPassword(),
        SizedBox(height: 10.h),

        LoginButton(
          emailController: emailController,
          passwordController: passwordController,
        ),

        SizedBox(height: 20.h),
        const DividerText(),
        SizedBox(height: 20.h),
        GoogleButton(),
        SizedBox(height: 15.h),
        const SignUp(),
      ],
    );
  }
}