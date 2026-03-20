import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final  Color colorText;
  final  double? fontsize;
  final FontWeight? fontWeight;

  const HeaderText({
    required this.text,
    this.colorText = Colors.black,
    this.fontWeight,
    this.fontsize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: colorText,
        fontSize: fontsize ?? 30.sp,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}
