import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../home/view/screens/home_page_screen.dart';
import '../../providers/auth_viewmodel_provider.dart';
import '../../providers/auth_repository_provider.dart';
import 'login_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    return authState.when(
      data: (user) {
        if (user == null) return const LoginScreen();
        if (!user.emailVerified) {
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
                      Text(
                        'Verify Your Email',
                        style: GoogleFonts.inter(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0XFF0F172A),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'We sent a verification email to ${user.email}. Please check your inbox and verify before continuing.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: const Color(0XFF64748B),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFF135bec),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onPressed: () async {
                            await ref
                                .read(authViewModelProvider.notifier)
                                .reloadUser();
                          },
                          child: Text(
                            "I've Verified My Email",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextButton(
                        onPressed: () async {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .resendVerificationEmail();
                        },
                        child: Text(
                          'Resend Verification Email',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: const Color(0XFF135bec),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextButton(
                        onPressed: () async {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .logout();
                        },
                        child: Text(
                          'Logout',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: const Color(0XFFEF4444),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const HomePageScreen();
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(child: Text('An error occurred: $error')),
      ),
    );
  }
}