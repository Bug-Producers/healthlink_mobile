import 'package:flutter/material.dart';
import 'package:healthlink_mobile/view/widgets/global_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          home: Scaffold(
            body: Center(
              child: GlobalButton(text: "text", height: 50.h, width: 350.w,
                  onPressed: (){
                    //TODO
                  }
              ),
            ),
          ),
        );
      },
    );
  }
}