import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/header_text.dart';
import '../../../auth/providers/auth_viewmodel_provider.dart';
import '../../../../features/booking/view/screens/my_appointments_screen.dart';

/**
 * @brief App bar for the medical home screen.
 * 
 * Contains branding, a button to view appointments, and a logout button.
 */

class MedicalAppBar extends ConsumerWidget {
  const MedicalAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
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
          Spacer(),
          // Calendar button
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyAppointmentsScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(8.r),
            child: Ink(
              height: 38.h,
              width: 38.w,
              decoration: BoxDecoration(
                color: Color(0XFFe8effe),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: SizedBox(
                  height: 25.h,
                  width: 25.h,
                  child: SvgPicture.asset(
                    "assets/Calendar.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Logout button
          InkWell(
            onTap: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  title: Text("Logout"),
                  content: Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: Text("Logout"),
                    ),
                  ],
                ),
              );
              if (confirmed == true) {
                await ref.read(authViewModelProvider.notifier).logout();
              }
            },
            borderRadius: BorderRadius.circular(8.r),
            child: Ink(
              height: 38.h,
              width: 38.w,
              decoration: BoxDecoration(
                color: Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Color(0xFFFECACA),
                  width: 1.w,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFEF4444),
                  size: 20.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}