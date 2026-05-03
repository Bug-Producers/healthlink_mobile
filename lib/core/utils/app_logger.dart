import 'dart:developer' as developer;

class AppLogger {
  static void info(String message, [String name = 'APP_INFO']) {
    developer.log(message, name: name);
  }

  static void warning(String message, [String name = 'APP_WARN']) {
    developer.log('⚠️ $message', name: name);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace, String name = 'APP_ERROR'}) {
    developer.log('❌ $message', error: error, stackTrace: stackTrace, name: name);
  }
}
