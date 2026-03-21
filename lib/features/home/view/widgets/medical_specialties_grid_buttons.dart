import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'medical_specialties_button.dart';
class MedicalSpecialtiesGridButtons extends StatelessWidget {
  const MedicalSpecialtiesGridButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 333.w,
      height: 510.h,
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          MedicalSpecialtiesButton(
            svgPath: 'assets/Cardiology.svg',
            name: 'Cardiology',
            color: Color(0XFFFBE3E3),
          ),
          MedicalSpecialtiesButton(
            svgPath: 'assets/Pediatrics.svg',
            name: 'Pediatrics',
            color: Color(0XFFD9E8FB),
          ),
          MedicalSpecialtiesButton(
            svgPath: 'assets/DentalIcon.svg',
            name: 'Dental',
            color: Color(0XFFD3F7EF),
          ),
          MedicalSpecialtiesButton(
            svgPath: 'assets/General.svg',
            name: 'General',
            color: Color(0XFFEDDEFB),
          ),
          MedicalSpecialtiesButton(
            svgPath: 'assets/Neurologysvg.svg',
            name: 'Neurology',
            color: Color(0xFFFCEFDF),
          ),
          MedicalSpecialtiesButton(
            svgPath: 'assets/EYE.svg',
            name: 'Ophthalmology',
            color: Color(0xFFD4F9DF),
          ),
          MedicalSpecialtiesButton(
            svgPath: 'assets/FemaleIcon.svg',
            name: 'Gynecology',
            color: Color(0XFFfbe3f0),
          ),
          MedicalSpecialtiesButton(
            svgPath: 'assets/Orthopedics.svg',
            name: 'Orthopedics',
            color: Color(0XFFfbf8d4),
          ),
        ],
      ),
    );
  }
}
