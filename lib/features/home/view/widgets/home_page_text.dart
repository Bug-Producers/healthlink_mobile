import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/descreption_text.dart';
import '../../../../core/widgets/header_text.dart';
class HomePageText extends StatelessWidget {
  const HomePageText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 333.w,
          child: HeaderText(text: "Find Your Doctor", fontsize: 28.sp),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          width: 333.w,
          child: DescriptionText(text: "Book an appointment in minutes"),
        ),
      ],
    );
  }
}