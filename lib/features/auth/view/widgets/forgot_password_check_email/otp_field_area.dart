import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'otp_field.dart';
class OtpFieldArea extends StatelessWidget {
  const OtpFieldArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 376.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OtpField(),
          OtpField(),
          OtpField(),
          OtpField(),
          OtpField(),
        ],
      ),
    );
  }
}
