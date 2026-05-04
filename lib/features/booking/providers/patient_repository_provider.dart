import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/patient_repository.dart';

/**
 * Provider for the PatientRepository.
 */
final patientRepositoryProvider = Provider<PatientRepository>((ref) {
  return PatientRepository();
});
