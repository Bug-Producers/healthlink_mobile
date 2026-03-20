import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/global_button.dart';
class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      text: 'Login',
      height: 58.h,
      width: 290.w,
      onPressed: () {
        //TODO
      },
    );
  }
}
