import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../models/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback? onTap;
  const DoctorCard({required this.doctor, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 338.w,
      height: 110.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0XFFF1F5F9), width: 1.w),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Doctor Image
          DoctorImage(doctor: doctor),
          SizedBox(width: 16.w),
          TextContent(doctor: doctor),
          SizedBox(width: 10.w),
          ButtonAction(onTap: onTap),
        ],
      ),
    );
  }
}

class ButtonAction extends StatelessWidget {
  const ButtonAction({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(4.r),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40.h,
          width: 40.w,
          margin: EdgeInsets.only(left: 8.w),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFF2563EB),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8.h),
          // Doctor Name
          AutoSizeText(
            doctor.name,
            maxLines: 1,
            minFontSize: 12,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),

          // Department & Clinic
          AutoSizeText(
            "${doctor.department} ● ${doctor.clinicName}",
            maxLines: 2,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: 3.h),

          // Rating and Patient Count
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 18.sp),
              SizedBox(width: 4.w),
              AutoSizeText(
                doctor.rating.toString(),
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4.w),
                AutoSizeText(
                  " (${doctor.patients} patients)",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                ),

            ],
          ),
        ],
      ),
    );
  }
}

class DoctorImage extends StatelessWidget {
  const DoctorImage({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: NetworkImage(doctor.profileImage),
          fit: BoxFit.contain,
        ),
        color: const Color(0xFFF1F5F9),
      ),
    );
  }
}