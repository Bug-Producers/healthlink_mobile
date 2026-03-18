import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../descreption_text.dart';
import '../header_text.dart';
class ForgotPasswordCheckEmailText extends StatelessWidget {
  const ForgotPasswordCheckEmailText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 376.w,
          child: HeaderText(text: "Check your email", fontsize: 20.sp),
        ),
        SizedBox(height: 7.h),
        SizedBox(
          width: 376.w,
          child: DescriptionText(
            text: "We sent a reset link to name@example.com",
          ),
        ),
        SizedBox(
          width: 376.w,
          child: DescriptionText(
            text: "enter 5 digit code that mentioned in the email",
          ),
        ),
      ],
    );
  }
}
