import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../global_button.dart';
class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      text: '"Reset Password',
      height: 56.h,
      width: 376.w,
      onPressed: () {
        //TODO
      },
    );
  }
}


