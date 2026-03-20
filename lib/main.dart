import 'package:flutter/material.dart';
import 'package:healthlink_mobile/previews/sandbox.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Sandbox(),
        );
      },
    );
  }
}