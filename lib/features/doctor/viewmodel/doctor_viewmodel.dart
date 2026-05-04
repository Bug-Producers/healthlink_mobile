import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/doctor_repository.dart';
import '../providers/doctor_repository_provider.dart';
import '../../../../core/models/appointment.dart';

/**
 * ViewModel for managing the state of a Doctor.
 */
class DoctorViewModel extends AsyncNotifier<Map<String, dynamic>?> {
  late final DoctorRepository _repo;

  @override
  Future<Map<String, dynamic>?> build() async {
    _repo = ref.read(doctorRepositoryProvider);
    // Fetch profile on build if user is a doctor. 
    // We handle it conditionally here or manually call fetchProfile.
    return null;
  }

  Future<void> fetchProfile() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getProfile();
    });
  }

  Future<bool> register({
    required String name,
    required String city,
    required String country,
    required String clinicName,
    required String about,
    required String department,
    required int expYears,
  }) async {
    return await _repo.register(
      name: name,
      city: city,
      country: country,
      clinicName: clinicName,
      about: about,
      department: department,
      expYears: expYears,
    );
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    await _repo.updateProfile(data);
    await fetchProfile(); // Refresh after update
  }

  Future<void> updateProfileImage(String base64Image) async {
    await _repo.updateProfileImage(base64Image);
  }

  Future<Map<String, dynamic>> getSchedule() async {
    return await _repo.getSchedule();
  }

  Future<void> updateSchedule(Map<String, dynamic> schedule) async {
    await _repo.updateSchedule(schedule);
  }

  Future<List<Appointment>> getAppointments() async {
    return await _repo.getAppointments();
  }

  Future<void> updateAppointmentStatus(String appointmentId, int status) async {
    await _repo.updateAppointmentStatus(appointmentId, status);
  }

  Future<Map<String, dynamic>> getRevenue() async {
    return await _repo.getRevenue();
  }

  Future<List<dynamic>> getRatings() async {
    return await _repo.getRatings();
  }
}
