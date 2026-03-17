import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class DividerText extends StatelessWidget {
  const DividerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 30.h),
        Expanded(
          child: Divider(color: Colors.grey[400], thickness: 1.5.h),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Or sign up with",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: Colors.grey[400], thickness: 1.5.h),
        ),
        SizedBox(width: 30.h),
      ],
    );
  }
}