import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/descreption_text.dart';
import '../../../../../core/widgets/header_text.dart';

class SetANewPasswordText extends StatelessWidget {
  const SetANewPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 376.w,
          child: HeaderText(text: "Set a new password", fontsize: 20.sp),
        ),
        //============================================================//
        SizedBox(height: 20.h),
        //============================================================//
        SizedBox(
          width: 376.w,
          child: DescriptionText(
            text: 'Create a new password, Ensure it differs from',
            fontsize: 14.sp,
          ),
        ),
        //============================================================//
        SizedBox(height: 3.h),
        //============================================================//
        SizedBox(
          width: 376.w,
          child: DescriptionText(
            text: 'previous ones for security',
            fontsize: 14.sp,
          ),
        ),
      ],
    );
  }
}