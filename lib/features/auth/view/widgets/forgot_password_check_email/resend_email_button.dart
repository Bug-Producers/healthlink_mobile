import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/descreption_text.dart';

class ResendEmailButton extends StatelessWidget {
  const ResendEmailButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DescriptionText(text: "Haven't got the email yet?", fontsize: 16.sp),
        TextButton(
          onPressed: () {
            //TODO
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.fromLTRB(6.w,0,0,0),
            minimumSize: Size(0, 0),
          ),
          child: Text(
            'Resend Email',
            style: GoogleFonts.inter(
                color: Color(0XFF135bec),
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}




