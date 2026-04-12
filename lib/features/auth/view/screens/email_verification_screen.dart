import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/global_button.dart';
import '../../../../../core/widgets/header_text.dart';
import '../../../../../core/widgets/descreption_text.dart';
import '../../providers/auth_viewmodel_provider.dart';

class EmailVerificationScreen extends ConsumerWidget {
  final String email;
  const EmailVerificationScreen({required this.email, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: const BoxDecoration(
                    color: Color(0XFFE8EFFE),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mark_email_unread_outlined,
                    color: const Color(0XFF135bec),
                    size: 40.r,
                  ),
                ),
                SizedBox(height: 24.h),
                HeaderText(
                  text: 'Verify Your Email',
                  fontsize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 12.h),
                DescriptionText(
                  text: 'We sent a verification email to $email. Please check your inbox and verify before continuing.',
                  fontsize: 14.sp,
                ),
                SizedBox(height: 32.h),
                GlobalButton(
                  text: "I've Verified My Email",
                  height: 52.h,
                  width: double.infinity,
                  onPressed: () async {
                    await ref
                        .read(authViewModelProvider.notifier)
                        .reloadUser();
                  },
                ),
                SizedBox(height: 16.h),
                GlobalButton(
                  text: 'Resend Verification Email',
                  height: 46.h,
                  width: double.infinity,
                  colorButton: const Color(0XFFE8EFFE),
                  colorText: const Color(0XFF135bec),
                  onPressed: () async {
                    await ref
                        .read(authViewModelProvider.notifier)
                        .resendVerificationEmail();
                  },
                ),
                SizedBox(height: 8.h),
                GlobalButton(
                  text: 'Logout',
                  height: 46.h,
                  width: double.infinity,
                  colorButton: const Color(0XFFFEF2F2),
                  colorText: const Color(0XFFEF4444),
                  onPressed: () async {
                    await ref
                        .read(authViewModelProvider.notifier)
                        .logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}