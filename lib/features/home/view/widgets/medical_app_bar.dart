import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/header_text.dart';
class MedicalAppBar extends StatelessWidget {
  const MedicalAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 333.w,
      height: 52.h,
      child: Row(
        children: [
          Container(
            height: 38.h,
            width: 38.w,
            decoration: BoxDecoration(
              color: Color(0XFFe8effe),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.medical_services_outlined,
              color: Color(0XFF135bec),
              size: 25.r,
            ),
          ),
          SizedBox(width: 5.w),
          HeaderText(
            text: "HealthLink",
            fontsize: 19.sp,
            fontWeight: FontWeight.bold,
          ),
          Spacer(),
          InkWell(
            onTap: () {
              //TODO
            },
            borderRadius: BorderRadius.circular(8.r),
            child: Ink(
              height: 38.h,
              width: 38.w,
              decoration: BoxDecoration(
                color: Color(0XFFe8effe),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: SizedBox(
                  height: 25.h,
                  width: 25.h,
                  child: SvgPicture.asset(
                    "assets/Calendar.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

