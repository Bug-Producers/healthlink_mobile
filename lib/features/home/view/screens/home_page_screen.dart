import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/header_text.dart';
import '../widgets/home_page_text.dart';
import '../widgets/medical_app_bar.dart';
import '../widgets/medical_specialties_grid_buttons.dart';
import '../widgets/search_button_in_home_page.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              MedicalAppBar(),
              SizedBox(
                width: 333.w,
                child: Divider(height: 23.h, color: Color(0XFFe2e8f0)),
              ),
              HomePageText(),
              SizedBox(height: 10.h),
              SearchButtonInHomePage(),
              SizedBox(height: 38.h),
              SizedBox(
                width: 333.w,
                child: HeaderText(
                  text: "Medical Specialties",
                  fontsize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.h),
              MedicalSpecialtiesGridButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
