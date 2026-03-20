import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/descreption_text.dart';
import '../../../../../core/widgets/header_text.dart';


class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(text: 'Welcome Back'),
        SizedBox(height: 5.h),
        DescriptionText(text: 'Sign in to access your health'),
        SizedBox(height: 3.h),
        DescriptionText(text: 'dashboard'),
      ],
    );
  }
}
