import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthlink_mobile/core/router/app_router.dart';
import 'firebase_options.dart';

/**
 * Main entry point for the HealthLink mobile application.
 * Initializes Firebase, Environment variables, and Screen scaling.
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables (.env file)
  await dotenv.load(fileName: ".env");
  
  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Start the app wrapped in a ProviderScope for Riverpod state management
  runApp(const ProviderScope(child: MyApp()));
}

/**
 * The root widget of the application.
 * Configures global styling, screen utilities, and navigation.
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'HealthLink',
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color(0XFF135bec),
            scaffoldBackgroundColor: Colors.white,
          ),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}