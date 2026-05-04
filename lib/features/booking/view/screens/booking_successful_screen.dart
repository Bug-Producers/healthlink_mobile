import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/core/widgets/global_button.dart';
import '../widgets/booking_successful/appoitment_summary.dart';
import '../widgets/booking_successful/booking_sucessful_text.dart';
import '../widgets/booking_successful/confirmation_app_bar.dart';

/**
 * Screen displayed when a patient successfully books an appointment.
 * Shows a success message and an appointment summary.
 */
class BookingSuccessfulScreen extends StatelessWidget {
  final String doctorName;
  final String date;
  final String timeRange;
  final String allocatedTime;

  const BookingSuccessfulScreen({
    super.key,
    required this.doctorName,
    required this.date,
    required this.timeRange,
    required this.allocatedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ConfirmationAppBar(),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 55.h),
              BookingSucessfulText(),
              SizedBox(height: 37.h),
              AppointmentSummary(
                doctorName: doctorName,
                date: date,
                timeRange: timeRange,
                allocatedTime: allocatedTime,
              ),
              SizedBox(height: 31.h),
              GlobalButton(
                text: "Done",
                height: 56.h,
                width: 342.w,
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
