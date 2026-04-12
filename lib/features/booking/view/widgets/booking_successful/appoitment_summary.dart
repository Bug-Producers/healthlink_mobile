import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/descreption_text.dart';
class AppointmentSummary extends StatelessWidget {
  const AppointmentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 344.h,
      width: 342.w,
      color: Color(0XFFf8fafc),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 300.w,
              child: DescriptionText(
                text: "APPOINTMENT SUMMARY",
                fontsize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Doctor",
                      style: TextStyle(
                        color: Color(0XFF475569),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        //TODO
                        "Dr. Sarah Mitchell",
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                Row(
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(
                        color: Color(0XFF475569),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        //TODO
                        "Oct 24, 2023",
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                Row(
                  children: [
                    Text(
                      "Chosen Period",
                      style: TextStyle(
                        color: Color(0XFF475569),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        //TODO
                        "3:00 PM - 5:00 PM",
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                Row(
                  children: [
                    Text(
                      "Allocated Time",
                      style: TextStyle(
                        color: Color(0XFF475569),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        //TODO
                        "3:30 PM",
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Color(0XFF135bec),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Divider(height: 1.h, color: const Color(0XFFe2e8f0)),
                Container(
                  height: 65.h,
                  width: 292.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.r),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.info_outline_rounded,
                            color: Color(0XFF135bec),
                          ),
                          SizedBox(width: 3.w),
                          DescriptionText(
                            text:
                            "Please arrive 15 minutes before your",
                            fontsize: 14.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      DescriptionText(
                        text:
                        "allocated time for check-in procedures",
                        fontsize: 14.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



