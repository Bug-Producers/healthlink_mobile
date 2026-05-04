import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/descreption_text.dart';

/**
 * Displays the final summary of a successfully booked appointment.
 */
class AppointmentSummary extends StatelessWidget {
  final String doctorName;
  final String date;
  final String timeRange;
  final String allocatedTime;

  const AppointmentSummary({
    super.key,
    required this.doctorName,
    required this.date,
    required this.timeRange,
    required this.allocatedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 104.h,
          width: 104.w,
          decoration: const BoxDecoration(
            color: Color(0XFFe8effe),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.check_circle_rounded,
              color: const Color(0XFF135bec),
              size: 50.sp,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              _SummaryRow(label: "Doctor", value: "Dr. $doctorName", isHighlighted: false),
              SizedBox(height: 30.h),
              _SummaryRow(label: "Date", value: date, isHighlighted: false),
              SizedBox(height: 30.h),
              _SummaryRow(label: "Chosen Period", value: timeRange, isHighlighted: false),
              SizedBox(height: 30.h),
              _SummaryRow(label: "Allocated Time", value: allocatedTime, isHighlighted: true),
              SizedBox(height: 30.h),
              Divider(height: 1.h, color: const Color(0XFFe2e8f0)),
              Container(
                height: 65.h,
                width: 292.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline_rounded, color: const Color(0XFF135bec)),
                        SizedBox(width: 5.w),
                        DescriptionText(
                          text: "Please arrive 15 minutes before your",
                          fontsize: 14.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    DescriptionText(
                      text: "allocated time for check-in procedures",
                      fontsize: 14.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/**
 * A helper widget to generate consistent rows for the summary.
 */
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlighted;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0XFF475569),
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: isHighlighted ? const Color(0XFF135bec) : Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
