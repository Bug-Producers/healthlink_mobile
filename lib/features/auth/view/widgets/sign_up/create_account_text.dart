import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/descreption_text.dart';
import '../../../../../core/widgets/header_text.dart';

class CreateAccountText extends StatelessWidget {
  const CreateAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 340.w,

          child: HeaderText(text: "Create Account", fontsize: 32.sp),
        ),
        //=======================================================//
        SizedBox(height: 5.h),
        //=======================================================//
        SizedBox(
          width: 340.w,
          child: DescriptionText(text: "Join HealthLink to manage your"),
        ),
        //=======================================================//
        SizedBox(height: 3.h),
        //=======================================================//
        SizedBox(
          width: 340.w,
          child: DescriptionText(text: "appointments"),
        ),
      ],
    );
  }
}