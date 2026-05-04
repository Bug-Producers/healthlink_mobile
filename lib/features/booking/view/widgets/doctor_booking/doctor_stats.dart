import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/core/models/doctor.dart';
import 'package:healthlink_mobile/core/widgets/descreption_text.dart';
import 'package:healthlink_mobile/core/widgets/header_text.dart';

/**
 * Displays key metrics for a doctor, such as rating, experience, and patient count.
 */
class DoctorStats extends StatelessWidget {
  final Doctor doctor;

  const DoctorStats({required this.doctor, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatCard(
          icon: Icons.star_border_purple500_outlined,
          title: "RATING",
          value: "${doctor.rating}/5",
        ),
        _StatCard(
          icon: Icons.work_history_outlined,
          title: "EXP.",
          value: "${doctor.expYears} yrs",
        ),
        _StatCard(
          icon: Icons.people_alt_outlined,
          title: "PATIENTS",
          value: "${doctor.patientsFormatted()}+",
        ),
      ],
    );
  }
}

// Internal helper widget for the cards
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 111.h,
      width: 111.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0XFFe2e8f0), width: 1.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0XFF135bec), size: 20.r),
          SizedBox(height: 8.h),
          DescriptionText(
            text: title,
            fontsize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 6.h),
          HeaderText(text: value, fontsize: 18.sp),
        ],
      ),
    );
  }
}