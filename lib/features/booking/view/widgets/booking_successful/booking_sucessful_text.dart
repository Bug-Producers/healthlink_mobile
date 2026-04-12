import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/descreption_text.dart';
import '../../../../../core/widgets/header_text.dart';
class BookingSucessfulText extends StatelessWidget {
  const BookingSucessfulText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: Color(0XFFe8effe),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline_rounded,
            color: Color(0XFF135bec),
            size: 70.sp,
            weight: 700.sp,
          ),
        ),
        SizedBox(height: 30.h),
        HeaderText(
          text: "Booking Successful",
          fontsize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 10.h),
        DescriptionText(
          text: "Your appointment has been successfully",
          fontsize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        DescriptionText(
          text: "scheduled and confirmed",
          fontsize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
