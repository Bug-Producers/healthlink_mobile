import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/header_text.dart';
import '../../../../../core/models/doctor.dart';

import '../../../../../core/utils/image_helper.dart';

/**
 * Displays the doctor's profile image, name, department, and location.
 */
class DoctorDetails extends StatelessWidget {
  const DoctorDetails({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: ImageHelper.getImageProvider(doctor.profileImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 18.h),

        HeaderText(
          text: 'Dr. ${doctor.name}',
          fontsize: 24.sp,
        ),
        SizedBox(height: 4.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: AutoSizeText(
            '${doctor.department} • ${doctor.clinicName}',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: const Color(0XFF135bec),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 7.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: const Color(0XFF64748b),
              size: 16.r,
            ),
            Flexible(
              child: AutoSizeText(
                " ${doctor.city}, ${doctor.country}",
                maxLines: 1,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0XFF64748b),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
