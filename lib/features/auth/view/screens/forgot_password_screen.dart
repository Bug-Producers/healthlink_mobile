import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/backward_button.dart';
import '../../../../core/widgets/descreption_text.dart';
import '../../../../core/widgets/header_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../widgets/forgot_password/reset_password_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 7.h),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 310.h, 0),
                child: const BackWardButton(),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: 376.w,
                child: HeaderText(text: "Forgot Password", fontsize: 20.sp),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 376.w,
                child: DescriptionText(
                  text: 'Please enter your email to reset the password',
                  fontsize: 14.sp,
                ),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: 376.w,
                child: Text(
                  "Your Email",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    color: const Color(0XFF334155),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              CustomTextField(
                controller: emailController,
                hintText: 'name@example.com',
                width: 376.w,
                icon: const Icon(Icons.email_outlined, color: Color(0XFF94a3b8)),
              ),
              SizedBox(height: 10.h),
              ResetPasswordButton(emailController: emailController),
            ],
          ),
        ),
      ),
    );
  }
}