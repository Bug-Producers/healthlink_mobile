import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/global_button.dart';
import '../../../providers/auth_viewmodel_provider.dart';

class GoogleButton extends ConsumerWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlobalButton(
      text: 'Google',
      height: 39.h,
      width: 292.w,
      colorButton: const Color(0XFFe8effe),
      colorText: const Color(0XFF475569),
      fontSize: 16.sp,
      onPressed: () async {
        await ref.read(authViewModelProvider.notifier).signInWithGoogle();
      },
    );
  }
}