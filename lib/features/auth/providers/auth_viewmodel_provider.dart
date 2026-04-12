import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/auth_viewmodel.dart';

final authViewModelProvider =
AsyncNotifierProvider<AuthViewModel, User?>(
  AuthViewModel.new,
);