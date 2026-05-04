import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

/**
 * @brief Singleton ApiClient that configures Dio with Firebase Auth tokens.
 *
 * This client provides the foundational HTTP methods (GET, POST, DELETE, etc.)
 * for the application, automatically appending the Bearer token for secure routes.
 */
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  /**
   * @brief Factory constructor to return the singleton instance.
   * @return ApiClient instance.
   */
  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        // Use 10.0.2.2 for Android Emulator, or localhost for iOS/Desktop
        baseUrl: 'http://10.0.2.2:8080/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Fetch the Firebase token and add to the headers
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final token = await user.getIdToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Log or handle errors globally here
          return handler.next(e);
        },
      ),
    );
  }
}
