import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/custom_text_field.dart';

class SignUpDataEntering extends StatelessWidget {
  const SignUpDataEntering({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 295.w,
          child: Text(
            "Full Name",
            textAlign: TextAlign.start,
            style: GoogleFonts.inter(
              color: Color(0XFF334155),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        //=======================================================//
        SizedBox(height: 5.h),
        //=======================================================//
        CustomTextField(
          hintText: 'Mike Anderson',
          width: 295.w,
          icon: Icon(Icons.person_outline_outlined, color: Color(0XFF94a3b8)),
        ),
        SizedBox(
          width: 295.w,
          child: Text(
            "Email Address",
            textAlign: TextAlign.start,
            style: GoogleFonts.inter(
              color: Color(0XFF334155),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        //=======================================================//
        SizedBox(height: 5.h),
        //=======================================================//
        CustomTextField(
          hintText: 'name@example.com',
          width: 295.w,
          icon: Icon(Icons.email_outlined, color: Color(0XFF94a3b8)),
        ),
        //=======================================================//
        SizedBox(height: 5.h),
        //=======================================================//
        SizedBox(
          width: 295.w,
          child: Text(
            "Password",
            textAlign: TextAlign.start,
            style: GoogleFonts.inter(
              color: Color(0XFF334155),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        //=======================================================//
        SizedBox(height: 5.h),
        //=======================================================//
        CustomTextField(
          hintText: '••••••••',
          isPassword: true,
          width: 295.w,
          icon: Icon(Icons.lock_outline, color: Color(0XFF94a3b8)),
        ),
        //=======================================================//
        SizedBox(height: 5.h),
        //=======================================================//
        SizedBox(
          width: 295.w,
          child: Text(
            "Confirm Password",
            textAlign: TextAlign.start,
            style: GoogleFonts.inter(
              color: Color(0XFF334155),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        //=======================================================//
        SizedBox(height: 5.h),
        //=======================================================//
        CustomTextField(
          hintText: '••••••••',
          isPassword: true,
          width: 295.w,
          icon: Icon(Icons.lock_outline, color: Color(0XFF94a3b8)),
        ),
      ],
    );
  }
}
