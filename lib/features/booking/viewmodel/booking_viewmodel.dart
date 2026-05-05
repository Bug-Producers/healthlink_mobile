import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/patient_repository.dart';
import '../providers/patient_repository_provider.dart';

/**
 * ViewModel for managing the state of booking an appointment.
 */
class BookingViewModel extends AsyncNotifier<void> {
  late final PatientRepository _repo;

  @override
  Future<void> build() async {
    _repo = ref.read(patientRepositoryProvider);
    return;
  }

  /**
   * Books an appointment, handling the loading and error states.
   * Returns the full response map from the backend on success.
   * 
   * @param doctorId The ID of the doctor.
   * @param date The chosen date.
   * @param dayOfWeek The day of the week.
   * @param frameStart The start time.
   * @param frameEnd The end time.
   */
  Future<Map<String, dynamic>?> bookAppointment({
    required String doctorId,
    required String date,
    required String dayOfWeek,
    required String frameStart,
    required String frameEnd,
  }) async {
    state = const AsyncLoading();
    Map<String, dynamic>? result;
    state = await AsyncValue.guard(() async {
      final response = await _repo.bookAppointment(
        doctorId: doctorId,
        date: date,
        dayOfWeek: dayOfWeek,
        frameStart: frameStart,
        frameEnd: frameEnd,
      );
      result = response;
    });
    return result;
  }
}
