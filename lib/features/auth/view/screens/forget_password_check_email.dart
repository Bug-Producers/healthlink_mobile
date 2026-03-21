import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/backward_button.dart';
import '../widgets/forgot_password_check_email/forgot_password_check_email_text.dart';
import '../widgets/forgot_password_check_email/otp_field_area.dart';
import '../widgets/forgot_password_check_email/resend_email_button.dart';
import '../widgets/forgot_password_check_email/verify_code_button.dart';
class ForgetPasswordCheckEmail extends StatelessWidget {
  const ForgetPasswordCheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 7.h),
              Padding(
                padding:  EdgeInsets.fromLTRB(0,0,310.h,0),
                child: BackWardButton(),
              ),
              SizedBox(height: 40.h),
              ForgotPasswordCheckEmailText(),
              SizedBox(height: 42.h),
              OtpFieldArea(),
              SizedBox(height: 24.h),
              VerifyCodeButton(),
              SizedBox(height: 40.h),
              ResendEmailButton(),
              SizedBox(height: 40.h),

            ],
          ),
        ),
      ),
    );
  }
}

