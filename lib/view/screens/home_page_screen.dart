import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthlink_mobile/view/widgets/descreption_text.dart';
import 'package:healthlink_mobile/view/widgets/header_text.dart';
import 'package:healthlink_mobile/view/widgets/medical_specialties_button.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 333.w,
                height: 52.h,
                child: Row(
                  children: [
                    Container(
                      height: 38.h,
                      width: 38.w,
                      decoration: BoxDecoration(
                        color: Color(0XFFe8effe),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.medical_services_outlined,
                        color: Color(0XFF135bec),
                        size: 25.r,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    HeaderText(
                      text: "HealthLink",
                      fontsize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 140.w),
                    Container(
                      height: 38.h,
                      width: 38.w,
                      decoration: BoxDecoration(
                        color: Color(0XFFe8effe),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 26.h,
                          width: 26.h,
                          child: SvgPicture.asset(
                            "assets/Calendar.svg",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 333.w,
                child: Divider(height: 23.h, color: Color(0XFFe2e8f0)),
              ),
              SizedBox(
                width: 333.w,
                child: HeaderText(text: "Find Your Doctor", fontsize: 28.sp),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: 333.w,
                child: DescriptionText(text: "Book an appointment in minutes"),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                child: Container(
                  width: 333.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: BoxBorder.all(width: 2.w, color: Color(0XFFe2e8f0)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 15.w),
                      Icon(
                        Icons.search,
                        color: Color(0XFF94a3b8),
                        size: 25.r,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 8.w),
                      DescriptionText(
                        text: "Search by doctor or specialty",
                        colorText: Color(0XFF94a3b8),
                        fontsize: 12.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 38.h),
              SizedBox(
                width: 333.w,
                child: HeaderText(
                  text: "Medical Specialties",
                  fontsize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 500.h,
                width: double.infinity,
                child: GridView.count(
                  crossAxisCount: 2,
                  children:  [
                    MedicalSpecialtiesButton(svgPath: 'assets/Cardiology.svg', name: 'Cardiology', color: Color(0XFFFBE3E3),),
                    MedicalSpecialtiesButton(svgPath: 'assets/Pediatrics.svg', name: 'Pediatrics', color: Color(0XFFD9E8FB),),
                    MedicalSpecialtiesButton(svgPath: 'assets/DentalIcon.svg', name: 'Dental', color: Color(0XFFD3F7EF),),
                    MedicalSpecialtiesButton(svgPath: 'assets/General.svg', name: 'General', color: Color(0XFFEDDEFB),),
                    MedicalSpecialtiesButton(svgPath: 'assets/Neurologysvg.svg', name: 'Neurology', color: Color(0xFFFCEFDF),),
                    MedicalSpecialtiesButton(svgPath: 'assets/EYE.svg', name: 'Ophthalmology', color: Color(0xFFD4F9DF),),
                    MedicalSpecialtiesButton(svgPath: 'assets/FemaleIcon.svg', name: 'Gynecology', color: Color(0XFFfbe3f0)),
                    MedicalSpecialtiesButton(svgPath: 'assets/Orthopedics.svg', name: 'Orthopedics', color: Color(0XFFfbf8d4)),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
