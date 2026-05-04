import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/patient_repository.dart';
import '../providers/patient_repository_provider.dart';

/**
 * ViewModel for managing the state of a Patient.
 */
class PatientViewModel extends AsyncNotifier<Map<String, dynamic>?> {
  late final PatientRepository _repo;

  @override
  Future<Map<String, dynamic>?> build() async {
    _repo = ref.read(patientRepositoryProvider);
    // Returning null by default since we don't have patientId here unless passed.
    // Use fetchProfile(patientId) to load data.
    return null;
  }

  Future<void> fetchProfile(String patientId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getPatientProfile(patientId);
    });
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    await _repo.updateProfile(data);
    // Assume profile needs a refresh, could update state directly if we have patientId
  }

  Future<void> updateProfileImage(String base64Image) async {
    await _repo.updateProfileImage(base64Image);
  }

  Future<bool> rateDoctor(String doctorId, int stars, String comment) async {
    return await _repo.rateDoctor(doctorId: doctorId, stars: stars, comment: comment);
  }

  Future<List<dynamic>> getHistory(String patientId) async {
    return await _repo.getHistory(patientId: patientId);
  }

  Future<bool> addHistoryReport(String patientId, String report) async {
    return await _repo.addHistoryReport(patientId: patientId, report: report);
  }

  Future<List<dynamic>> getNotifications() async {
    return await _repo.getNotifications();
  }
}
