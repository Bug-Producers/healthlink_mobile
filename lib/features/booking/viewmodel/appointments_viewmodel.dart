import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/appointment.dart';
import '../repositories/patient_repository.dart';
import '../providers/patient_repository_provider.dart';
import '../../../../core/utils/app_logger.dart';

/**
 * ViewModel for managing the state of a patient's appointments.
 *
 * Maintains a local cache so that appointments created via the booking flow
 * are displayed immediately, even if the backend GET endpoint fails.
 */
class AppointmentsViewModel extends AsyncNotifier<List<Appointment>> {
  PatientRepository get _repo => ref.read(patientRepositoryProvider);

  /// Local cache of appointments added from booking responses.
  final List<Appointment> _localCache = [];

  @override
  Future<List<Appointment>> build() async {
    return _fetchAppointments();
  }

  Future<List<Appointment>> _fetchAppointments() async {
    try {
      final remote = await _repo.getAppointments();
      // If the API succeeds, merge with any locally cached appointments
      // that might not yet be in the remote list.
      final remoteIds = remote.map((a) => a.id).toSet();
      final merged = [
        ...remote,
        ..._localCache.where((a) => !remoteIds.contains(a.id)),
      ];
      return merged;
    } catch (e, st) {
      AppLogger.error('Error fetching appointments', error: e, stackTrace: st, name: 'AppointmentsVM');
      // If the API fails, return whatever we have cached locally.
      if (_localCache.isNotEmpty) {
        return List.from(_localCache);
      }
      return [];
    }
  }

  /// Adds an appointment from a successful booking response to the local cache
  /// and updates the state immediately.
  void addFromBookingResponse(Map<String, dynamic> response, {String? doctorName, String? doctorImage}) {
    final appointment = Appointment(
      id: response['id'] as String? ?? '',
      doctorId: response['doctorId'] as String? ?? '',
      doctorName: doctorName ?? (response['doctorName'] as String?),
      doctorImage: doctorImage ?? (response['doctorImage'] as String?),
      date: response['date'] as String? ?? '',
      startTime: response['startTime'] as String? ?? '',
      endTime: response['endTime'] as String? ?? '',
      duration: response['duration'] as int? ?? 0,
      status: response['status'] as int? ?? 0,
    );

    // Avoid duplicates
    _localCache.removeWhere((a) => a.id == appointment.id);
    _localCache.add(appointment);

    // Update state immediately
    final current = state.hasValue ? state.value! : <Appointment>[];
    final existingIds = current.map((a) => a.id).toSet();
    if (!existingIds.contains(appointment.id)) {
      state = AsyncData([...current, appointment]);
    }

    AppLogger.info('Added appointment ${appointment.id} to local cache', 'AppointmentsVM');
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
      if (success) {
        // Remove from local cache as well
        _localCache.removeWhere((a) => a.id == id);
        await refresh();
      }
    } catch (e) {
      // Also remove locally if cancel was attempted
      _localCache.removeWhere((a) => a.id == id);
      AppLogger.error('Error cancelling appointment', error: e, name: 'AppointmentsVM');
      rethrow;
    }
  }
}
