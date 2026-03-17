import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../global_button.dart';
class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      text: 'Create Account',
      height: 58.h,
      width: 295.w,
      onPressed: () {
        //TODO
      },
    );
  }
}