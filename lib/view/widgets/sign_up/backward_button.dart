import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BackWardButton extends StatelessWidget {
  const BackWardButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 310.w, 0),
      child: Container(
        height: 40.h,
        width: 54.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(15.r),
        ),
        child: IconButton(
          onPressed: () {
            //TODO
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 30,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Color(0XFFeef4fc),
          ),
        ),
      ),
    );
  }
}
