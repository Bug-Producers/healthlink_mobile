import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/backward_button.dart';
import '../widgets/Login/google_button.dart';
import '../widgets/Login/signup_divider.dart';
import '../widgets/sign_up/create_account_button.dart';
import '../widgets/sign_up/create_account_text.dart';
import '../widgets/sign_up/sign_up_data_entering.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 7.h),
                BackWardButton(),
                SizedBox(height: 18.h),
                CreateAccountText(),
                SizedBox(height: 50.h),
                SignUpDataEntering(),
                SizedBox(height: 40.h),
                CreateAccountButton(),
                SizedBox(height: 30.h),
                DividerText(),
                SizedBox(height: 30.h),
                GoogleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






