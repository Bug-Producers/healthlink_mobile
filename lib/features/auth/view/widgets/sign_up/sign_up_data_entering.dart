import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/custom_text_field.dart';

class SignUpDataEntering extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpDataEntering({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _label("Full Name"),
        SizedBox(height: 5.h),
        CustomTextField(
          controller: nameController,
          hintText: 'Mike Anderson',
          width: 295.w,
          icon: const Icon(Icons.person_outline_outlined, color: Color(0XFF94a3b8)),
        ),
        SizedBox(height: 5.h),
        _label("Email Address"),
        SizedBox(height: 5.h),
        CustomTextField(
          controller: emailController,
          hintText: 'name@example.com',
          width: 295.w,
          icon: const Icon(Icons.email_outlined, color: Color(0XFF94a3b8)),
        ),
        SizedBox(height: 5.h),
        _label("Password"),
        SizedBox(height: 5.h),
        CustomTextField(
          controller: passwordController,
          hintText: '••••••••',
          isPassword: true,
          width: 295.w,
          icon: const Icon(Icons.lock_outline, color: Color(0XFF94a3b8)),
        ),
        SizedBox(height: 5.h),
        _label("Confirm Password"),
        SizedBox(height: 5.h),
        CustomTextField(
          controller: confirmPasswordController,
          hintText: '••••••••',
          isPassword: true,
          width: 295.w,
          icon: const Icon(Icons.lock_outline, color: Color(0XFF94a3b8)),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return SizedBox(
      width: 295.w,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: GoogleFonts.inter(
          color: const Color(0XFF334155),
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}