import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/view/screens/home_page_screen.dart';
import '../../providers/auth_viewmodel_provider.dart';
import 'email_verification_screen.dart';
import 'login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    return authState.when(
      data: (user) {
        if (user == null) return const LoginScreen();
        if (!user.emailVerified) {
          return EmailVerificationScreen(email: user.email ?? '');
        }
        return const HomePageScreen();
      },
      loading: () => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(height: 16.h),
              Text(
                'Verifying authentication...',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
      // Instead of an error page, return to LoginScreen. The LoginScreen's listener will show the SnackBar.
      error: (error, stackTrace) => const LoginScreen(),
    );
  }
}