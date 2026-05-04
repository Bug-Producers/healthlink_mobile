import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/appointment.dart';
import '../repositories/patient_repository.dart';
import '../providers/patient_repository_provider.dart';
import '../../../../core/utils/app_logger.dart';

/**
 * ViewModel for managing the state of a patient's appointments.
 */
class AppointmentsViewModel extends AsyncNotifier<List<Appointment>> {
  PatientRepository get _repo => ref.read(patientRepositoryProvider);

  @override
  Future<List<Appointment>> build() async {
    return _fetchAppointments();
  }

  Future<List<Appointment>> _fetchAppointments() async {
    try {
      return await _repo.getAppointments();
    } catch (e, st) {
      AppLogger.error('Error fetching appointments', error: e, stackTrace: st, name: 'AppointmentsVM');
      rethrow;
    }
  }

  /// Refreshes the list of appointments.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchAppointments());
  }

  /// Cancels an appointment and refreshes the list.
  /// [id] The ID of the appointment to cancel.
  Future<void> cancelAppointment(String id) async {
    try {
      final success = await _repo.cancelAppointment(id);
      if (success && state.hasValue) {
        await refresh();
      }
    } catch (e) {
      AppLogger.error('Error cancelling appointment', error: e, name: 'AppointmentsVM');
      rethrow;
    }
  }
}
