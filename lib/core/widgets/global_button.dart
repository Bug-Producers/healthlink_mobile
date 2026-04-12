import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalButton extends StatelessWidget {
  final String text;
  final Color colorButton;
  final Color colorText;
  final double? fontSize;
  final double? cornerRadius;
  final double width;
  final double height;
  final bool isLoading;
  final VoidCallback onPressed;

  const GlobalButton({
    required this.text,
    required this.height,
    required this.width,
    required this.onPressed,
    this.isLoading = false,
    this.colorButton = const Color(0XFF135bec),
    this.colorText = Colors.white,
    this.cornerRadius,
    this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius ?? 10.r),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
          height: 20.h,
          width: 20.h,
          child: CircularProgressIndicator(
            color: colorText,
            strokeWidth: 2,
          ),
        )
            : Text(
          text,
          style: TextStyle(color: colorText, fontSize: fontSize ?? 16.sp),
        ),
      ),
    );
  }
}