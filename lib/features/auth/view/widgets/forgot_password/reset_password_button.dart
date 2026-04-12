import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../core/widgets/global_button.dart';
import '../../../providers/auth_viewmodel_provider.dart';
import '../../screens/pop_up_screen.dart';
import '../../../../../core/utils/app_validator.dart';
import '../../../../../core/utils/auth_exception_handler.dart';

class ResetPasswordButton extends ConsumerStatefulWidget {
  final TextEditingController emailController;

  const ResetPasswordButton({
    super.key,
    required this.emailController,
  });

  @override
  ConsumerState<ResetPasswordButton> createState() => _ResetPasswordButtonState();
}

class _ResetPasswordButtonState extends ConsumerState<ResetPasswordButton> {
  bool _isLoading = false;

  void _handleResetPassword() async {
    FocusScope.of(context).unfocus();
    final email = widget.emailController.text.trim();

    final validationError = AppValidator.validateEmail(email);
    if (validationError != null) {
      CustomSnackBar.showError(context, message: validationError);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(authViewModelProvider.notifier).forgetPassword(email);

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29.36.r),
            ),
            child: const PopUpScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context,
          message: AuthExceptionHandler.handleException(e),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      text: 'Reset Password',
      height: 56.h,
      width: 376.w,
      isLoading: _isLoading,
      onPressed: _handleResetPassword,
    );
  }
}