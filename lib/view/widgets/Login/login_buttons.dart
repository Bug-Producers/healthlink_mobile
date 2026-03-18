
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/view/widgets/Login/signup_button.dart';
import 'package:healthlink_mobile/view/widgets/Login/signup_divider.dart';

import '../../screens/sign_up_screen.dart';
import 'forgot_password_button.dart';
import 'google_button.dart';
import 'login_button.dart';

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
        DividerText(),
        SizedBox(height: 20.h),
        GoogleButton(),
        SizedBox(height: 15.h),
        SignUp(),
      ],
    );
  }
}

