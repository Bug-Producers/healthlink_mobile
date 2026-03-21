import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/descreption_text.dart';
class SearchButtonInHomePage extends StatelessWidget {
  const SearchButtonInHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 333.w,
        height: 52.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 2.w, color: Color(0XFFe2e8f0)),
        ),
        child: Row(
          children: [
            SizedBox(width: 15.w),
            Icon(Icons.search, color: Color(0XFF94a3b8), size: 25.r),
            SizedBox(width: 8.w),
            DescriptionText(
              text: "Search by doctor or specialty",
              colorText: Color(0XFF94a3b8),
              fontsize: 12.sp,
            ),
          ],
        ),
      ),
    );
  }
}


