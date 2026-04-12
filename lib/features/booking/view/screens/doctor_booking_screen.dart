import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/core/models/doctor.dart';
import 'package:healthlink_mobile/core/widgets/header_text.dart';
import '../../../../core/models/day_schedule.dart';
import '../widgets/doctor_booking/app_bar_doctor_details.dart';
import '../widgets/doctor_booking/day_tiles.dart';
import '../widgets/doctor_booking/doctor_about.dart';
import '../widgets/doctor_booking/doctor_details.dart';
import '../widgets/doctor_booking/doctor_stats.dart';

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
  int? selectedTimeIndex;

  // ✅ format time
  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    final slots = widget.schedule[selectedIndex].slots;

    return Scaffold(
      appBar: AppBar(
        title: AppBarDoctorDetails(),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              DoctorDetails(widget: widget),
              SizedBox(height: 40.h),
              DoctorStats(doctor: widget.doctor),
              SizedBox(height: 37.h),
              DoctorAbout(widget: widget),
              SizedBox(height: 40.h),

              // 📦 Schedule Container
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
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText(text: "Select Schedule", fontsize: 18.sp),
                    SizedBox(height: 20.h),

                    // 📅 Days
                    SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.schedule.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: DayTile(
                              isSelected: index == selectedIndex,
                              dayName: widget.schedule[index].day.name,
                              dayNumber: widget.schedule[index].number.toString(),
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  selectedTimeIndex = null; // reset الوقت
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20.h),
                    HeaderText(text: "Available Time", fontsize: 18.sp),
                    SizedBox(height: 12.h),

                    // ⏰ Time Slots
                    slots.isEmpty
                        ? Center(
                      child: Text(
                        "No available times",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    )
                        : Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: slots.asMap().entries.map((entry) {
                        int index = entry.key;
                        var slot = entry.value;

                        bool isSelected = selectedTimeIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTimeIndex = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0XFF135bec)
                                  : const Color(0XFF135bec)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              "${formatTime(slot.start)} - ${formatTime(slot.end)}",
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0XFF135bec),
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // 🔘 Book Button
              ElevatedButton(
                onPressed: selectedTimeIndex == null
                    ? null
                    : () {
                  final slot =
                  slots[selectedTimeIndex!];

                  print("Booked: ${formatTime(slot.start)}");
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  backgroundColor: const Color(0XFF135bec),
                ),
                child: Text(
                  "Book Appointment",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}