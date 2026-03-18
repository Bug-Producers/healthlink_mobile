import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
