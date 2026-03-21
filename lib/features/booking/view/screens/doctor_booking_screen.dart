import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthlink_mobile/core/models/doctor.dart';
import 'package:healthlink_mobile/core/widgets/backward_button.dart';
import 'package:healthlink_mobile/core/widgets/descreption_text.dart';
import 'package:healthlink_mobile/core/widgets/header_text.dart';

import '../../../../core/models/day_schedule.dart';
import '../widgets/doctor_booking/day_tiles.dart';

class DoctorBookingScreen extends StatefulWidget {
  final Doctor doctor;
  final List<DaySchedule> schedule;

  const DoctorBookingScreen({
    required this.doctor,
    required this.schedule,
    super.key,
  });

  @override
  State<DoctorBookingScreen> createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:                   AppBar(title:                   AppBarDoctorDetails(),backgroundColor: Colors.transparent,),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [

                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.doctor.profileImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),

                  HeaderText(
                    text: 'Dr. ${widget.doctor.name}',
                    fontsize: 24.sp,
                  ),
                  SizedBox(height: 4.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: AutoSizeText(
                      '${widget.doctor.department} • ${widget.doctor.clinicName}',
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
                          " ${widget.doctor.city}, ${widget.doctor.country}",
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

                  SizedBox(height: 40.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoCard(
                        icon: Icons.star_border_purple500_outlined,
                        title: "RATING",
                        value: "${widget.doctor.rating}/5",
                      ),
                      _infoCard(
                        icon: Icons.work_history_outlined,
                        title: "EXP.",
                        value: "${widget.doctor.expYears} yrs",
                      ),
                      _infoCard(
                        icon: Icons.people_alt_outlined,
                        title: "PATIENTS",
                        value: "${widget.doctor.patientsFormatted()}+",
                      ),
                    ],
                  ),

                  SizedBox(height: 37.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: HeaderText(
                      text: "About",
                      fontsize: 18.sp,
                    ),
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

                  SizedBox(height: 40.h),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderText(
                          text: "Select Schedule",
                          fontsize: 18.sp,
                        ),
                        SizedBox(height: 20.h),

                        SizedBox(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.schedule.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: DayTile(
                                  isSelected: index == selectedIndex,
                                  dayName: widget.schedule[index].day.name,
                                  dayNumber:
                                  widget.schedule[index].number.toString(),
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      height: 111.h,
      width: 111.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0XFFe2e8f0),
          width: 1.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0XFF135bec),
            size: 20.r,
          ),
          SizedBox(height: 8.h),
          DescriptionText(
            text: title,
            fontsize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 6.h),
          HeaderText(
            text: value,
            fontsize: 18.sp,
          ),
        ],
      ),
    );
  }
}

class AppBarDoctorDetails extends StatelessWidget {
  const AppBarDoctorDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            BackWardButton(),
            Expanded(
              child: Center(
                child: HeaderText(
                  text: "Doctor Details",
                  fontsize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 40.w),
          ],
        ),
        SizedBox(height: 8.h),
        Divider(
          height: 1.h,
          color: const Color(0XFFe2e8f0),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}