import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/core/models/doctor.dart';
import 'package:healthlink_mobile/core/widgets/header_text.dart';
import '../../../../core/models/day_schedule.dart';
import '../widgets/doctor_booking/app_bar_doctor_details.dart';
import '../widgets/doctor_booking/day_tiles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/doctor_booking/doctor_about.dart';
import '../widgets/doctor_booking/doctor_details.dart';
import '../widgets/doctor_booking/doctor_stats.dart';
import '../../providers/booking_viewmodel_provider.dart';
import 'booking_successful_screen.dart';

/**
 * @brief Screen to view doctor details and book an appointment.
 * 
 * Displays doctor information, available schedule, and handles booking.
 */
class DoctorBookingScreen extends ConsumerStatefulWidget {
  /**
   * @param doctor The doctor model to book.
   * @param schedule The doctor's available schedule slots.
   */
  final Doctor doctor;
  final List<DaySchedule> schedule;

  const DoctorBookingScreen({
    required this.doctor,
    required this.schedule,
    super.key,
  });

  @override
  ConsumerState<DoctorBookingScreen> createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends ConsumerState<DoctorBookingScreen> {
  int selectedIndex = 0;
  int? selectedTimeIndex;

  /**
   * @brief Formats a TimeOfDay object into a readable string (e.g. 12:00 PM).
   * 
   * @param time The TimeOfDay object.
   * @return The formatted time string.
   */
  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return "$hour:$minute $period";
  }

  /**
   * @brief Formats a TimeOfDay to HH:MM 24-hour string for backend.
   */
  String _formatForBackend(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  /**
   * @brief Books the appointment by calling the backend API via ViewModel.
   */
  Future<void> _bookAppointment() async {
    if (selectedTimeIndex == null) return;

    try {
      final scheduleDay = widget.schedule[selectedIndex];
      final slot = scheduleDay.slots[selectedTimeIndex!];
      
      // Calculate a dummy date string based on the selected day (for now we use a fixed future date or compute next day of week)
      // Since DaySchedule only gives us the Day enum, we will just send a dummy date for demo purposes
      final dummyDate = "2025-04-20";
      
      await ref.read(bookingViewModelProvider.notifier).bookAppointment(
        doctorId: widget.doctor.uuid,
        date: dummyDate,
        dayOfWeek: scheduleDay.day.name.toLowerCase(),
        frameStart: _formatForBackend(slot.start),
        frameEnd: _formatForBackend(slot.end),
      );

      // Check if there was an error in state
      if (ref.read(bookingViewModelProvider).hasError) {
        throw ref.read(bookingViewModelProvider).error!;
      }

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BookingSuccessfulScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final slots = widget.schedule[selectedIndex].slots;
    final bookingState = ref.watch(bookingViewModelProvider);
    final isLoading = bookingState.isLoading;

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
                onPressed: (selectedTimeIndex == null || isLoading)
                    ? null
                    : _bookAppointment,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  backgroundColor: const Color(0XFF135bec),
                ),
                child: isLoading 
                    ? const SizedBox(
                        height: 20, 
                        width: 20, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                    : Text(
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