import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/backward_button.dart';
import '../../../../../core/widgets/header_text.dart';
class AppBarDoctorDetails extends StatelessWidget {
  const AppBarDoctorDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            BackWardButton(),
            Expanded(
              child: Center(
                child: HeaderText(
                  text: "Doctor Details",
                  fontsize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 40.w),
          ],
        ),
        SizedBox(height: 8.h),
        Divider(
          height: 1.h,
          color: const Color(0XFFe2e8f0),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}