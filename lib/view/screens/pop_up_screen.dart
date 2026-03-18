import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/view/widgets/descreption_text.dart';
import 'package:healthlink_mobile/view/widgets/global_button.dart';
import 'package:healthlink_mobile/view/widgets/header_text.dart';

class PopUpScreen extends StatelessWidget {
  const PopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215.h,
      width: 392.64.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusGeometry.circular(29.36.r),
        border: Border.all(color: Color(0XFFBEBEBE), width: 1.w),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            HeaderText(text: "Successful", fontsize: 18.sp),
            SizedBox(height: 22.h),
            DescriptionText(text: "Congratulations! Your password has"),
            DescriptionText(text: "been changed. Click continue to login"),
            SizedBox(height: 25.h),
            GlobalButton(
              text: "Continue",
              height: 51.37.h,
              width: 344.94.w,
              fontSize: 18.sp,

              onPressed: (){
                //TODO
              },
            ),
          ],
        ),
      ),
    );
  }
}
