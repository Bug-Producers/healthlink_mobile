import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../providers/auth_viewmodel_provider.dart';
import '../widgets/Login/data_entering.dart';
import '../widgets/Login/login_buttons.dart';
import '../widgets/Login/logo.dart';
import '../widgets/Login/welcome_text.dart';
import '../../../../../core/utils/auth_exception_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        ref.listen(authViewModelProvider, (prev, next) {
          next.whenOrNull(
            error: (error, _) {
              CustomSnackBar.showError(
                context,
                message: AuthExceptionHandler.handleException(error),
              );
            },
          );
        });

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 38.h),
                    const Logo(),
                    SizedBox(height: 30.h),
                    const WelcomeText(),
                    SizedBox(height: 65.h),
                    DataEntering(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    LoginButtons(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}