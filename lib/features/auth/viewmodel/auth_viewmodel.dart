 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../providers/auth_repository_provider.dart';
import '../../../../core/utils/app_logger.dart';

class AuthViewModel extends AsyncNotifier<User?> {
  late final AuthRepository _repo;

  @override
  Future<User?> build() async {
    _repo = ref.read(authRepositoryProvider);
    final user = _repo.currentUser;
    if (user != null) {
      await user.reload();
      return _repo.currentUser;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    AppLogger.info('Attempting login for email: $email', 'AuthViewModel');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        final result = await _repo.login(email: email, password: password);
        AppLogger.info('Login successful', 'AuthViewModel');
        return result.user;
      } catch (e, st) {
        AppLogger.error('Login failed', error: e, stackTrace: st, name: 'AuthViewModel');
        rethrow;
      }
    });
  }

  Future<void> register(String email, String password, String username) async {
    AppLogger.info('Attempting registration for email: $email', 'AuthViewModel');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        final result = await _repo.register(
          email: email,
          password: password,
          username: username,
        );
        AppLogger.info('Registration successful', 'AuthViewModel');
        return result.user;
      } catch (e, st) {
        AppLogger.error('Registration failed', error: e, stackTrace: st, name: 'AuthViewModel');
        rethrow;
      }
    });
  }

  Future<void> signInWithGoogle() async {
    AppLogger.info('Attempting Google Sign-In', 'AuthViewModel');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        final result = await _repo.signInWithGoogle();
        if (result == null) {
          AppLogger.info('Google Sign-In cancelled by user', 'AuthViewModel');
          return null;
        }
        AppLogger.info('Google Sign-In successful', 'AuthViewModel');
        return result.user;
      } catch (e, st) {
        AppLogger.error('Google Sign-In failed', error: e, stackTrace: st, name: 'AuthViewModel');
        rethrow;
      }
    });
  }

  Future<void> reloadUser() async {
    await _repo.reloadUser();
    final user = _repo.currentUser;
    state = AsyncData(user);
  }

  Future<void> resendVerificationEmail() async {
    await _repo.resendVerificationEmail();
  }

  Future<void> forgetPassword(String email) async {
    await _repo.forgetPassword(email);
  }

  Future<bool> isDoctor(String uid) async {
    try {
      return await _repo.isDoctor(uid);
    } catch (e) {
      AppLogger.error('Failed to check if user is doctor', error: e, name: 'AuthViewModel');
      return false;
    }
  }

  Future<void> logout() async {
    AppLogger.info('Logging out user', 'AuthViewModel');
    await _repo.logout();
    state = const AsyncData(null);
  }
}