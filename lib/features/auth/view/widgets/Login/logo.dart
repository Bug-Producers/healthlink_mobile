import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72.w,
          height: 72.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0XFFE8EFFE),
          ),
          child: Icon(
            Icons.medical_services_outlined,
            size: 30.r,
            color: Color(0XFF135bec),
          ),
        ),
      ],
    );
  }
}
