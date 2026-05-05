import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

/**
 * Singleton ApiClient that configures Dio with Firebase Auth tokens.
 *
 * This client provides the foundational HTTP methods (GET, POST, DELETE, etc.)
 * for the application, automatically appending the Bearer token for secure routes.
 */
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  /**
   * Factory constructor to return the singleton instance.
   */
  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    final baseUrl = dotenv.env['API_BASE_URL'] ?? '';

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
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
      ),
    );
    
    // Add Auto-Retry Interceptor
    dio.interceptors.add(RetryInterceptor(dio: dio));
  }
}

/**
 * Interceptor to automatically retry failed network requests due to timeouts or socket exceptions.
 */
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryInterval;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryInterval = const Duration(seconds: 2),
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      int retryCount = err.requestOptions.extra['retryCount'] ?? 0;
      if (retryCount < maxRetries) {
        retryCount++;
        err.requestOptions.extra['retryCount'] = retryCount;
        
        debugPrint('Auto-retrying request (${err.requestOptions.path}). Attempt $retryCount/$maxRetries. Error: ${err.type}');
        
        await Future.delayed(retryInterval);
        
        try {
          final options = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            extra: err.requestOptions.extra,
            responseType: err.requestOptions.responseType,
            contentType: err.requestOptions.contentType,
            validateStatus: err.requestOptions.validateStatus,
            receiveTimeout: err.requestOptions.receiveTimeout,
            sendTimeout: err.requestOptions.sendTimeout,
          );
          
          final response = await dio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: options,
            cancelToken: err.requestOptions.cancelToken,
            onReceiveProgress: err.requestOptions.onReceiveProgress,
            onSendProgress: err.requestOptions.onSendProgress,
          );
          return handler.resolve(response);
        } catch (e) {
          if (e is DioException) {
            // Keep retrying if it's still failing
            return super.onError(e, handler);
          }
        }
      }
    }
    // Pass the error to the next interceptor if it shouldn't be retried or max retries reached
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.sendTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError ||
           err.error is SocketException;
  }
}
