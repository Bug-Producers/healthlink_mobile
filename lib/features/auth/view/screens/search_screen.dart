import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/doctor.dart';
import '../../../../core/widgets/backward_button.dart';
import '../../../../core/widgets/descreption_text.dart';
import '../../../../core/widgets/doctor_card.dart';
import '../../../../core/widgets/header_text.dart';



class SearchScreen extends StatelessWidget {
  final List<Doctor> doctors;
  SearchScreen({super.key,required this.doctors});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackWardButton(),
        centerTitle: true,
        title: HeaderText(
          text: "Find Care",
          fontsize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Divider(height: 1.h, color: const Color(0XFFe2e8f0)),
            SizedBox(height: 16.h),

            // Search Bar
            InkWell(
              onTap: () {
                // TODO: Handle search navigation
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: double.infinity,
                height: 55.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    width: 2.w,
                    color: const Color(0XFFf8fafc),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15.w),
                    Icon(Icons.search, color: const Color(0XFF64748b), size: 25.r),
                    SizedBox(width: 8.w),
                    DescriptionText(
                      text: "Search doctors, clinics, or specialty",
                      colorText: const Color(0XFF64748b),
                      fontsize: 14.sp,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32.h),

            HeaderText(text: "Suggested Doctors", fontsize: 18.sp),

            SizedBox(height: 16.h),

            // FIXED: Wrapped in Expanded to prevent unbounded height error
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 24.h),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h), // Space between cards
                    child: DoctorCard(
                      doctor: doctors[index],
                      onTap: () {
                        // TODO: Navigate to Doctor Details
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}