import 'package:firebase_auth/firebase_auth.dart';

class AuthExceptionHandler {
  static String handleException(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'Invalid email or password.';
        case 'email-already-in-use':
          return 'This email is already registered.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        default:
          return 'An error occurred: ${error.message}';
      }
    }
    return error.toString();
  }
}