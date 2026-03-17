import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionText extends StatelessWidget {
  String text;
  Color colorText;
  double? fontsize;


  DescriptionText({
    required this.text,
    this.colorText =const Color(0XFF64748b),
    this.fontsize,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(color:colorText,fontSize: fontsize?? 16.sp,fontWeight: FontWeight.normal),
    );
  }
}
