import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final double? width;
  final double? height;
  final bool? isPassword;
  final Widget? icon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.height,
    this.width,
    this.isPassword,
    this.icon,
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hidden;

  Widget? suffix() {
    if (widget.isPassword == true) {
      return IconButton(
        onPressed: () {
          setState(() {
            hidden = !hidden;
          });
        },
        icon: Icon(hidden ? Icons.visibility_off : Icons.visibility),
      );
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    hidden = widget.isPassword == true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 292.w,
      height: widget.height ?? 56.h,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword == true ? hidden : false,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          suffixIcon: suffix(),
          prefixIcon: widget.icon != null
              ? Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: widget.icon,
          )
              : null,
          prefixIconConstraints: BoxConstraints(
            minWidth: 28.w,
            minHeight: 28.h,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: Color(0xFFe2e8f0),
              width: 5.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: Color(0xFFe2e8f0),
              width: 1.w,
            ),
          ),
        ),
      ),
    );
  }
}