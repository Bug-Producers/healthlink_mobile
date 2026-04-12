import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/custom_text_field.dart';

class DataEntering extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const DataEntering({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 325.w,
          child: Text(
            'Email Address',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0XFF334155),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 7.h),

        CustomTextField(
          controller: emailController,
          hintText: 'name@example.com',
          width: 325.w,
          icon: const Icon(Icons.email_outlined, color: Color(0XFF94a3b8)),
        ),

        SizedBox(height: 10.h),

        SizedBox(
          width: 325.w,
          child: Text(
            'Password',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0XFF334155),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 7.h),

        CustomTextField(
          controller: passwordController,
          hintText: '••••••••',
          isPassword: true,
          width: 325.w,
          icon: const Icon(Icons.lock_outline, color: Color(0XFF94a3b8)),
        ),
      ],
    );
  }
}