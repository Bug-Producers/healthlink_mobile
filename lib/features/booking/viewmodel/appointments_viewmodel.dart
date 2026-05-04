import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/appointment.dart';
import '../repositories/patient_repository.dart';
import '../providers/patient_repository_provider.dart';
import '../../../../core/utils/app_logger.dart'; // Assuming this exists or falls back to print

/**
 * @brief ViewModel for managing the state of a patient's appointments.
 */
class AppointmentsViewModel extends AsyncNotifier<List<Appointment>> {
  late final PatientRepository _repo;

  @override
  Future<List<Appointment>> build() async {
    _repo = ref.read(patientRepositoryProvider);
    return _fetchAppointments();
  }

  Future<List<Appointment>> _fetchAppointments() async {
    try {
      return await _repo.getAppointments();
    } catch (e, st) {
      // Add simple print if AppLogger is not available
      print('Error fetching appointments: $e\n$st');
      rethrow;
    }
  }

  /**
   * @brief Refreshes the list of appointments.
   */
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchAppointments());
  }

  /**
   * @brief Cancels an appointment and removes it from the list.
   * 
   * @param id The ID of the appointment to cancel.
   */
  Future<void> cancelAppointment(String id) async {
    // We don't want to set the whole screen to loading, just perform the action
    // and if successful, remove it from the current state.
    try {
      final success = await _repo.cancelAppointment(id);
      if (success && state.hasValue) {
        final currentList = state.value!;
        // Filter out the cancelled appointment or just refresh from server
        // We'll just refresh from server to ensure accuracy
        await refresh();
      }
    } catch (e) {
      print('Error cancelling appointment: $e');
      rethrow;
    }
  }
}
