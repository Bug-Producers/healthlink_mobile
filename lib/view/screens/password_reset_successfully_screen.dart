import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/backward_button.dart';
import '../widgets/password_reset_successfully/password_reset_confirmation_button.dart';
import '../widgets/password_reset_successfully/password_reset_successfully_text.dart';

class PasswordResetSuccessfullyScreen extends StatelessWidget {
  const PasswordResetSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 7.h),
              BackWardButton(),
              SizedBox(height: 40.h),
              PasswordResetSuccessfullyText(),
              SizedBox(height: 40.h),
              ResettingPasswordConfirmationButton(),
            ],
          ),
        ),
      ),
    );
  }
}



