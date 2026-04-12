import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../providers/auth_repository_provider.dart';

class AuthViewModel extends AsyncNotifier<User?> {
  late final AuthRepository _repo;

  @override
  Future<User?> build() async {
    _repo = ref.read(authRepositoryProvider);
    return _repo.currentUser;
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
      return result?.user;
    });
  }

  Future<void> forgetPassword(String email) async {
    await _repo.forgetPassword(email);
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AsyncData(null);
  }
}