import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(240.w, 0, 0, 0),
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forgot Password?',
          style: GoogleFonts.inter(
            color: Color(0XFF135bec),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}