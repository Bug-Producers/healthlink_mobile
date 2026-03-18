import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthlink_mobile/view/widgets/descreption_text.dart';
import 'package:healthlink_mobile/view/widgets/global_button.dart';
import 'package:healthlink_mobile/view/widgets/header_text.dart';

import '../widgets/backward_button.dart';

class ForgetPasswordCheckEmail extends StatelessWidget {
  const ForgetPasswordCheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 7.h),
              BackWardButton(),
              SizedBox(height: 40.h),

              SizedBox(
                width: 376.w,
                child: HeaderText(text: "Check your email", fontsize: 20.sp),
              ),
              SizedBox(height: 7.h),

              SizedBox(
                width: 376.w,
                child: DescriptionText(
                  text: "We sent a reset link to name@example.com",
                ),
              ),
              SizedBox(
                width: 376.w,
                child: DescriptionText(
                  text: "enter 5 digit code that mentioned in the email",
                ),
              ),
              SizedBox(height: 42.h),

              SizedBox(
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
              ),
              SizedBox(height: 24.h),
              GlobalButton(
                text: "Verify Code",
                height: 56.h,
                width: 376.w,
                onPressed: () {
                  //TODO
                },
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                     DescriptionText(text: "Haven't got the email yet?", fontsize: 16.sp),
                  TextButton(
                    onPressed: () {
                      //TODO
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(6.w,0,0,0),
                      minimumSize: Size(0, 0),
                    ),
                    child: Text(
                      'Resend Email',
                      style: GoogleFonts.inter(
                        color: Color(0XFF135bec),
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpField extends StatelessWidget {
  const OtpField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.w,
      height: 56.h,
      child: TextField(
        onEditingComplete: (){

        },
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.sp),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 2.w),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
