import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../descreption_text.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        DescriptionText(text: "Don't have an account?",fontsize: 14.sp),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.fromLTRB(5.w,0,0,0),
            minimumSize: Size(0, 0),
          ),
          child: Text(
            'Sign Up',
            style: GoogleFonts.inter(
              color: Color(0XFF135bec),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}