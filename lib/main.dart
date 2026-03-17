import 'package:flutter/material.dart';
import 'package:healthlink_mobile/view/screens/login_screen.dart';
import 'package:healthlink_mobile/view/widgets/custom_text_field.dart';
import 'package:healthlink_mobile/view/widgets/descreption_text.dart';
import 'package:healthlink_mobile/view/widgets/global_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/view/widgets/header_text.dart';


void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        );
      },
    );
  }
}