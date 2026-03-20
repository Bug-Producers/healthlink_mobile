import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/descreption_text.dart';
import '../../../../../core/widgets/header_text.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 376.w,
          child: HeaderText(text: "Forgot Password", fontsize: 20.sp),
        ),
        //============================================================//
        SizedBox(height: 20.h),
        //============================================================//
        SizedBox(
          width: 376.w,
          child: DescriptionText(
            text: 'Please enter your email to reset the password',
            fontsize: 14.sp,
          ),
        ),
      ],
    );
  }
}