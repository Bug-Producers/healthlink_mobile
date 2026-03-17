import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../global_button.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      text: 'Google',
      height: 39.h,
      width: 292.w,
      colorButton: Color(0XFFe8effe),
      colorText: Color(0XFF475569),
      fontSize: 16.sp,
      onPressed: () {
        //TODO
      },
    );
  }
}