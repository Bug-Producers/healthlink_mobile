import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/descreption_text.dart';
import '../../../../../core/widgets/header_text.dart';

class PasswordResetSuccessfullyText extends StatelessWidget {
  const PasswordResetSuccessfullyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 376.w,
          child: HeaderText(text: "Password Reset", fontsize: 20.sp),
        ),
        //============================================================//
        SizedBox(height: 20.h),
        //============================================================//
        SizedBox(
          width: 376.w,
          child: DescriptionText(
            text: 'Your password has been successfully reset,',
            fontsize: 14.sp,
          ),
        ),
        //============================================================//
        SizedBox(height: 3.h),
        //============================================================//
        SizedBox(
          width: 376.w,
          child: DescriptionText(
            text: 'click confirm to set a new password',
            fontsize: 14.sp,
          ),
        ),

      ],
    );
  }
}
