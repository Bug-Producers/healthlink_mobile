import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/header_text.dart';
import '../../screens/doctor_booking_screen.dart';
class DoctorAbout extends StatelessWidget {
  const DoctorAbout({
    super.key,
    required this.widget,
  });

  final DoctorBookingScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: HeaderText(text: "About", fontsize: 18.sp),
        ),
        SizedBox(height: 19.h),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.doctor.about,
            style: GoogleFonts.inter(
              color: const Color(0XFF475569),
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
