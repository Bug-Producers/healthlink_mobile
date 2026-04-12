import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../providers/auth_repository_provider.dart';

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
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _repo.login(email: email, password: password);
      return result.user;
    });
  }

  Future<void> register(String email, String password, String username) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _repo.register(
        email: email,
        password: password,
        username: username,
      );
      return result.user;
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _repo.signInWithGoogle();
      if (result == null) return null;
      return result.user;
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

  Future<void> logout() async {
    await _repo.logout();
    state = const AsyncData(null);
  }
}