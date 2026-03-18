import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthlink_mobile/view/widgets/global_button.dart';

import '../widgets/backward_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/descreption_text.dart';
import '../widgets/header_text.dart';
import '../widgets/set_a_new_password/password_entering.dart';
import '../widgets/set_a_new_password/set_a_new_password_text.dart';
import '../widgets/set_a_new_password/update_password_button.dart';
class SetANewPasswordScreen extends StatelessWidget {
  const SetANewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 7.h),
              BackWardButton(),
              SetANewPasswordText(),
              SizedBox(height: 42.h),
              PasswordEntering(),
              SizedBox(height: 25.h),
              UpdatePasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}

