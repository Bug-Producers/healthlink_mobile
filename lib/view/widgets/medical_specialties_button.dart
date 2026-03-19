import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicalSpecialtiesButton extends StatelessWidget {
  final String svgPath;
  final String name;
  final Color color;
 const MedicalSpecialtiesButton({
    super.key,
    required this.svgPath,
    required this.name,
  required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 113.49.h,
        width: 159.07.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.16.r),
          border: Border.all(color: Color(0XFFf1f5f9), width: 1.w),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 52.h,
              width: 52.w,
              decoration: BoxDecoration(shape: BoxShape.circle,color: color,),
             child: Center(
               child: SizedBox(
               height: 28.h,width: 28.h,
                   child: SvgPicture.asset(svgPath,fit: BoxFit.contain,)),
             ),
            ),
            SizedBox(height:15.h),
             Text(name,
               style: TextStyle(color: Colors.black,fontSize: 14.sp),
             ),
          ],
        ),
      ),
    );
  }
}
