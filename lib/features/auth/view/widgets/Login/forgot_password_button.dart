import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/router/app_router.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 240.w),
      child: TextButton(
        onPressed: () {
          context.push(AppRouter.forgotPassword);
        },
        child: Text(
          'Forgot Password?',
          style: GoogleFonts.inter(
            color: const Color(0XFF135bec),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}