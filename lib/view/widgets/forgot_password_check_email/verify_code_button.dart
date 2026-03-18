import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../global_button.dart';
class VerifyCodeButton extends StatelessWidget {
  const VerifyCodeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      text: "Verify Code",
      height: 56.h,
      width: 376.w,
      onPressed: () {
        //TODO
      },
    );
  }
}
