import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../custom_text_field.dart';
class ForgotPasswordDataEntering extends StatelessWidget {
  const ForgotPasswordDataEntering({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 376.w,
          child: Text(
            "Your Email",
            textAlign: TextAlign.start,
            style: GoogleFonts.inter(
              color: Color(0XFF334155),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        //============================================================//
        SizedBox(height: 5.h),
        //============================================================//
        CustomTextField(
          hintText: 'name@example.com',
          width: 376.w,
          icon: Icon(Icons.email_outlined, color: Color(0XFF94a3b8)),
        ),
      ],
    );
  }
}

