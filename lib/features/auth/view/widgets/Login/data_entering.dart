import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/custom_text_field.dart';
class DataEntering extends StatelessWidget {
  const DataEntering({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 325.w,
          child: Text(
            'Email Address',
            textAlign: TextAlign.start,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Color(0XFF334155),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 7.h),
        CustomTextField(
          hintText: 'name@example.com',
          width: 325.w,
          icon: Icon(Icons.email_outlined, color: Color(0XFF94a3b8)),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: 325.w,
          child: Text(
            'Password',
            textAlign: TextAlign.start,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Color(0XFF334155),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 7.h),
        CustomTextField(
          hintText: '••••••••',
          isPassword: true,
          width: 325.w,
          icon: Icon(Icons.lock_outline, color: Color(0XFF94a3b8)),
        ),
      ],
    );
  }
}

