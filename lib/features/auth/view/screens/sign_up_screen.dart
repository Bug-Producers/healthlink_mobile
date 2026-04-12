import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_viewmodel_provider.dart';
import '../../../../core/widgets/backward_button.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/Login/google_button.dart';
import '../widgets/Login/signup_divider.dart';
import '../widgets/sign_up/create_account_button.dart';
import '../widgets/sign_up/create_account_text.dart';
import '../widgets/sign_up/sign_up_data_entering.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authViewModelProvider, (prev, next) {
      next.whenData((user) {
        if (user != null) {
          context.go(AppRouter.authGate);
        }
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 7.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 310.h, 0),
                  child: const BackWardButton(),
                ),
                SizedBox(height: 18.h),
                const CreateAccountText(),
                SizedBox(height: 50.h),
                SignUpDataEntering(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),
                SizedBox(height: 40.h),
                CreateAccountButton(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),
                SizedBox(height: 30.h),
                const DividerText(),
                SizedBox(height: 30.h),
                const GoogleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}