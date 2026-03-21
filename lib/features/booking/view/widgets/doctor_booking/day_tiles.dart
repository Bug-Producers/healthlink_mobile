import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DayTile extends StatelessWidget {
  final bool isSelected;
  final String dayName;
  final String dayNumber;
  final VoidCallback onTap;

  const DayTile({
    super.key,
    required this.isSelected,
    required this.dayName,
    required this.dayNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 96.h,
        width: 70.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? Color(0XFF135bec) : Color(0XFFe2e8f0),
            width: isSelected ? 3.w : 2.w,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 22.h),
            Text(
              dayName,
              style: GoogleFonts.inter(
                color: isSelected ? Color(0XFF135bec) : Color(0XFF64748B),
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              dayNumber,
              style: GoogleFonts.inter(
                color: isSelected ? Color(0XFF135bec) : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
