import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/doctor_repository.dart';

final doctorRepositoryProvider = Provider<DoctorRepository>((ref) {
  return DoctorRepository();
});
