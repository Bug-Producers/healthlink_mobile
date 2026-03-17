import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Login/data_entering.dart';
import '../widgets/Login/forgot_password_button.dart';
import '../widgets/Login/google_button.dart';
import '../widgets/Login/login_button.dart';
import '../widgets/Login/logo.dart';
import '../widgets/Login/signup_button.dart';
import '../widgets/Login/signup_divder.dart';
import '../widgets/Login/welcome_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 38.h),
              Logo(),
              SizedBox(height: 30.h),
              WelcomeText(),
              SizedBox(height: 65.h),
              DataEntering(),
              LoginButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
class LoginButtons extends StatelessWidget {
  const LoginButtons({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ForgotPassword(),
        SizedBox(height: 10.h),
        LoginButton(),
        SizedBox(height: 20.h),
        DeviderText(),
        SizedBox(height: 20.h),
        GoogleButton(),
        SizedBox(height: 15.h),
        SignUp(),
      ],
    );
  }
}







