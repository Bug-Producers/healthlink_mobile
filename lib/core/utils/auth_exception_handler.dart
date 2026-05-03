import 'package:firebase_auth/firebase_auth.dart';

class AuthExceptionHandler {
  static String handleException(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'Invalid email or password.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'email-already-in-use':
          return 'This email is already registered. Please sign in instead.';
        case 'weak-password':
          return 'Password is too weak. Please use a stronger password.';
        case 'operation-not-allowed':
          return 'Operation not allowed. Please contact support.';
        case 'network-request-failed':
          return 'Network error. Please check your internet connection.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        default:
          return 'Authentication error: ${error.message ?? 'Unknown error occurred.'}';
      }
    }
    
    // For non-Firebase errors, strip "Exception: " if present for cleaner UI
    final errorString = error.toString();
    if (errorString.startsWith('Exception: ')) {
      return errorString.substring(11);
    }
    return 'An unexpected error occurred: $errorString';
  }
}