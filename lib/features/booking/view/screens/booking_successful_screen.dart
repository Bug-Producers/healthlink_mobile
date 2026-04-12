import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/core/widgets/global_button.dart';
import '../widgets/booking_successful/appoitment_summary.dart';
import '../widgets/booking_successful/booking_sucessful_text.dart';
import '../widgets/booking_successful/confirmation_app_bar.dart';

class BookingSuccessfulScreen extends StatelessWidget {
  const BookingSuccessfulScreen({super.key});

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
              AppointmentSummary(),
              SizedBox(height: 31.h),
              GlobalButton(
                text: "Done",
                height: 56.h,
                width: 342.w,
                onPressed: () {
                  //TODO
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

