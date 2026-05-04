import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/core/models/doctor.dart';
import 'package:healthlink_mobile/core/widgets/header_text.dart';
import 'package:healthlink_mobile/core/models/day_schedule.dart';
import 'package:healthlink_mobile/core/models/day.dart';
import 'package:healthlink_mobile/core/models/time_slot.dart';
import '../widgets/doctor_booking/app_bar_doctor_details.dart';
import '../widgets/doctor_booking/day_tiles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/doctor_booking/doctor_about.dart';
import '../widgets/doctor_booking/doctor_details.dart';
import '../widgets/doctor_booking/doctor_stats.dart';
import 'package:healthlink_mobile/features/booking/providers/booking_viewmodel_provider.dart';
import 'package:healthlink_mobile/features/booking/providers/patient_repository_provider.dart';
import 'booking_successful_screen.dart';

/**
 * Screen to view doctor details and book an appointment.
 * Displays doctor information, available schedule, and handles booking.
 */
class DoctorBookingScreen extends ConsumerStatefulWidget {
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
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  List<DaySchedule> _liveSchedule = [];
  bool _isFetchingSchedule = false;

  @override
  void initState() {
    super.initState();
    if (widget.schedule.isNotEmpty) {
      _liveSchedule = widget.schedule;
    } else {
      _fetchSchedule();
    }
  }

  /**
   * Fetches the doctor's weekly schedule from the API.
   */
  Future<void> _fetchSchedule() async {
    setState(() => _isFetchingSchedule = true);
    try {
      final repo = ref.read(patientRepositoryProvider);
      final rawData = await repo.getDoctorSchedule(widget.doctor.uuid);
      
      // Parse the map availability: {"monday": [...], "tuesday": [...]}
      final List<DaySchedule> parsed = [];
      int dayNum = 1;
      (rawData as Map<String, dynamic>).forEach((key, value) {
        parsed.add(DaySchedule(
          day: Day.values.firstWhere(
            (e) => e.name.toLowerCase() == key.toLowerCase(), 
            orElse: () => Day.MON,
          ),
          number: dayNum++,
          slots: (value as List).map((e) => TimeSlot.fromJson(e)).toList(),
        ));
      });

      setState(() {
        _liveSchedule = parsed;
        _isFetchingSchedule = false;
      });
    } catch (e) {
      setState(() => _isFetchingSchedule = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load schedule: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  /**
   * Opens a date picker to select the appointment date.
   */
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  /**
   * Formats a TimeOfDay object into a readable string (e.g. 12:00 PM).
   */
  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return "$hour:$minute $period";
  }

  /**
   * Formats a TimeOfDay to HH:MM 24-hour string for backend.
   */
  String _formatForBackend(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  /**
   * Books the appointment by calling the backend API via ViewModel.
   */
  Future<void> _bookAppointment() async {
    if (selectedTimeIndex == null) return;

    try {
      final scheduleDay = _liveSchedule[selectedIndex];
      final slot = scheduleDay.slots[selectedTimeIndex!];
      
      final dateStr = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      final timeRange = "${formatTime(slot.start)} - ${formatTime(slot.end)}";
      
      await ref.read(bookingViewModelProvider.notifier).bookAppointment(
        doctorId: widget.doctor.uuid,
        date: dateStr,
        dayOfWeek: scheduleDay.day.name.toLowerCase(),
        frameStart: _formatForBackend(slot.start),
        frameEnd: _formatForBackend(slot.end),
      );

      final state = ref.read(bookingViewModelProvider);
      if (state.hasError) {
        throw state.error!;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Appointment booked successfully!")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingSuccessfulScreen(
              doctorName: widget.doctor.name,
              date: dateStr,
              timeRange: timeRange,
              allocatedTime: formatTime(slot.start),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Booking failed: ${e.toString()}"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final slots = _liveSchedule.isNotEmpty ? _liveSchedule[selectedIndex].slots : [];
    final bookingState = ref.watch(bookingViewModelProvider);
    final isLoading = bookingState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const AppBarDoctorDetails(),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
              SizedBox(height: 24.h),

              // 📅 Date Selection
              InkWell(
                onTap: _selectDate,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0XFFe2e8f0), width: 1.w),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_outlined, color: const Color(0XFF135bec), size: 24.r),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Appointment Date", style: TextStyle(color: const Color(0XFF64748b), fontSize: 12.sp)),
                          Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down, color: Color(0XFF64748b)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

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

                    SizedBox(
                      height: 100.h,
                      child: _isFetchingSchedule 
                        ? const Center(child: CircularProgressIndicator())
                        : _liveSchedule.isEmpty 
                          ? Center(child: Text("No schedule available", style: TextStyle(fontSize: 14.sp)))
                          : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _liveSchedule.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: DayTile(
                                  isSelected: index == selectedIndex,
                                  dayName: _liveSchedule[index].day.name,
                                  dayNumber: _liveSchedule[index].number.toString(),
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      selectedTimeIndex = null;
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