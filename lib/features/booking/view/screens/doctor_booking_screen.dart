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
import 'package:healthlink_mobile/features/booking/providers/appointments_viewmodel_provider.dart';
import 'package:healthlink_mobile/features/booking/providers/patient_repository_provider.dart';
import 'package:healthlink_mobile/core/models/doctor_schedule_complete.dart';
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

  List<DaySchedule> _liveSchedule = [];
  bool _isFetchingSchedule = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    if (widget.schedule.isNotEmpty) {
      _liveSchedule = widget.schedule;
    } else {
      _fetchSchedule();
    }
  }

  int _timeToMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  List<TimeSlot> _generateSlots(List<AvailabilityWindow> windows, DateTime date) {
    List<TimeSlot> slots = [];
    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;
    final currentMinutes = now.hour * 60 + now.minute;

    for (var window in windows) {
      int currentStart = _timeToMinutes(window.startTime);

      if (!isToday || currentStart > currentMinutes) {
        slots.add(TimeSlot(
          start: window.startTime,
          end: window.endTime,
        ));
      }
    }
    return slots;
  }

  String _getFullDayName(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday - 1];
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
        ),
      );
  }

  /**
   * Fetches the doctor's weekly schedule from the API.
   */
  Future<void> _fetchSchedule() async {
    setState(() {
      _isFetchingSchedule = true;
      _hasError = false;
    });
    try {
      final repo = ref.read(patientRepositoryProvider);
      
      final scheduleComplete = await repo.getDoctorScheduleComplete(widget.doctor.uuid);
      
      final now = DateTime.now();
      final upcomingDates = List.generate(30, (i) => now.add(Duration(days: i)));
      
      final List<DaySchedule> parsed = [];

      for (var date in upcomingDates) {
        final dayEnum = Day.values[(date.weekday - 1) % 7];
        final dayString = _getFullDayName(date.weekday).toLowerCase();
        
        final windows = scheduleComplete.availability[dayString] ?? [];
        if (windows.isEmpty) continue; // Skip days with no availability

        final slots = _generateSlots(windows, date);
        if (slots.isEmpty) continue; // Skip if no slots can be generated

        parsed.add(DaySchedule(
          day: dayEnum,
          number: date.day,
          date: date,
          slots: slots,
        ));
      }


      setState(() {
        _liveSchedule = parsed;
        _isFetchingSchedule = false;
        selectedIndex = 0;
        selectedTimeIndex = null;
      });
    } catch (e, stackTrace) {
      debugPrint('[Schedule] ❌ Failed to load schedule: $e');
      debugPrint('[Schedule] Stack trace: $stackTrace');
      setState(() {
        _isFetchingSchedule = false;
        _hasError = true;
        _errorMessage = "We couldn't load the doctor's schedule. Please check your connection and try again.";
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
    if (_liveSchedule.isEmpty || selectedTimeIndex == null) return;
    if (selectedIndex < 0 || selectedIndex >= _liveSchedule.length) return;

    try {
      final scheduleDay = _liveSchedule[selectedIndex];
      final slot = scheduleDay.slots[selectedTimeIndex!];

      final dateToBook = scheduleDay.date ?? DateTime.now();
      final dateStr =
          "${dateToBook.year}-${dateToBook.month.toString().padLeft(2, '0')}-${dateToBook.day.toString().padLeft(2, '0')}";

      final timeRange = "${formatTime(slot.start)} - ${formatTime(slot.end)}";

      final bookingResponse =
          await ref.read(bookingViewModelProvider.notifier).bookAppointment(
                doctorId: widget.doctor.uuid,
                date: dateStr,
                dayOfWeek: _getFullDayName(dateToBook.weekday).toLowerCase(),
                frameStart: _formatForBackend(slot.start),
                frameEnd: _formatForBackend(slot.end),
              );

      final bookingState = ref.read(bookingViewModelProvider);
      if (bookingState.hasError) {
        throw Exception(bookingState.error?.toString() ?? 'Unknown booking error');
      }

      // Cache the appointment locally so it shows on the home screen immediately
      if (bookingResponse != null) {
        ref.read(appointmentsViewModelProvider.notifier).addFromBookingResponse(
          bookingResponse,
          doctorName: widget.doctor.name,
          doctorImage: widget.doctor.profileImage,
        );
      }

      final allocatedStart = bookingResponse?['startTime'] as String?;
      final allocatedEnd = bookingResponse?['endTime'] as String?;
      String? allocatedTime;
      if (allocatedStart != null && allocatedEnd != null) {
        allocatedTime = "$allocatedStart - $allocatedEnd";
      } else {
        allocatedTime = allocatedStart;
      }

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingSuccessfulScreen(
            doctorName: widget.doctor.name,
            date: dateStr,
            timeRange: timeRange,
            allocatedTime: allocatedTime ?? formatTime(slot.start),
          ),
        ),
      );
    } catch (e) {
      debugPrint('[Booking] ❌ Failed: $e');
      _showSnackBar("Booking failed: ${e.toString()}", isError: true);
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_rounded, color: Colors.red[400], size: 40.sp),
          SizedBox(height: 12.h),
          Text(
            "Connection Error",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.red[800]),
          ),
          SizedBox(height: 8.h),
          Text(
            _errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.sp, color: Colors.red[600]),
          ),
          SizedBox(height: 16.h),
          ElevatedButton.icon(
            onPressed: _fetchSchedule,
            icon: Icon(Icons.refresh_rounded, size: 18.sp, color: Colors.white),
            label: Text("Retry Connection", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slots = _liveSchedule.isNotEmpty ? _liveSchedule[selectedIndex].slots : <TimeSlot>[];
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

                    if (_hasError)
                      _buildErrorWidget()
                    else if (_isFetchingSchedule)
                      SizedBox(
                        height: 100.h,
                        child: const Center(child: CircularProgressIndicator())
                      )
                    else if (_liveSchedule.isEmpty)
                      SizedBox(
                        height: 100.h, 
                        child: Center(
                          child: Text("No schedule available for the next 30 days.", style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]))
                        )
                      )
                    else ...[
                      SizedBox(
                        height: 100.h,
                        child: ListView.builder(
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
                                "No available times for this day",
                                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
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