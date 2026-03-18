import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Login/data_entering.dart';
import '../widgets/Login/forgot_password_button.dart';
import '../widgets/Login/google_button.dart';
import '../widgets/Login/login_button.dart';
import '../widgets/Login/login_buttons.dart';
import '../widgets/Login/logo.dart';
import '../widgets/Login/signup_button.dart';
import '../widgets/Login/signup_divider.dart';
import '../widgets/Login/welcome_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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





