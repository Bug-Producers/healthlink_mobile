import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/global_button.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../providers/auth_viewmodel_provider.dart';
import '../../../../../core/utils/app_validator.dart';
import '../../../../../core/utils/auth_exception_handler.dart';

class CreateAccountButton extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const CreateAccountButton({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authViewModelProvider).isLoading;

    ref.listen(authViewModelProvider, (prev, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null && prev?.isLoading == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Verification email sent. Please check your inbox.')),
            );
          }
        },
        error: (error, _) {
          CustomSnackBar.showError(
            context,
            message: AuthExceptionHandler.handleException(error),
          );
        },
      );
    });

    return GlobalButton(
      text: 'Create Account',
      height: 58.h,
      width: 295.w,
      isLoading: isLoading,
      onPressed: () async {
        FocusScope.of(context).unfocus();

        final nameError = AppValidator.validateName(nameController.text);
        if (nameError != null) {
          CustomSnackBar.showError(context, message: nameError);
          return;
        }

        final emailError = AppValidator.validateEmail(emailController.text);
        if (emailError != null) {
          CustomSnackBar.showError(context, message: emailError);
          return;
        }

        final passwordError = AppValidator.validatePassword(passwordController.text);
        if (passwordError != null) {
          CustomSnackBar.showError(context, message: passwordError);
          return;
        }

        final confirmError = AppValidator.validateConfirmPassword(
          passwordController.text,
          confirmPasswordController.text,
        );
        if (confirmError != null) {
          CustomSnackBar.showError(context, message: confirmError);
          return;
        }

        await ref.read(authViewModelProvider.notifier).register(
          emailController.text.trim(),
          passwordController.text.trim(),
          nameController.text.trim(),
        );
      },
    );
  }
}