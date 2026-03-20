import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/backward_button.dart';
import '../widgets/forgot_password/forgot_password_data_entering.dart';
import '../widgets/forgot_password/forgot_password_text.dart';
import '../widgets/forgot_password/reset_password_button.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 7.h),
              BackWardButton(),
              SizedBox(height: 30.h),
              ForgotPasswordText(),
              SizedBox(height: 30.h),
              ForgotPasswordDataEntering(),
              SizedBox(height: 10.h),
              ResetPasswordButton(),


            ],
          ),
        ),
      ),
    );
  }
}

