import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../core/widgets/global_button.dart';
import '../../../providers/auth_viewmodel_provider.dart';
import '../../../../../core/utils/app_validator.dart';

class LoginButton extends ConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authViewModelProvider).isLoading;

    return GlobalButton(
      text: 'Login',
      height: 58.h,
      width: 290.w,
      isLoading: isLoading,
      onPressed: () {
        FocusScope.of(context).unfocus();
        final email = emailController.text.trim();
        final password = passwordController.text;

        final emailError = AppValidator.validateEmail(email);
        if (emailError != null) {
          CustomSnackBar.showError(context, message: emailError);
          return;
        }

        if (password.isEmpty) {
          CustomSnackBar.showError(context, message: 'Password is required');
          return;
        }

        ref.read(authViewModelProvider.notifier).login(email, password);
      },
    );
  }
}