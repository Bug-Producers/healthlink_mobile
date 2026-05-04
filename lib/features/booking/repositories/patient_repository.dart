import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/models/appointment.dart';

/**
 * @brief Repository for interacting with the backend Patient API.
 * 
 * Handles all patient-facing endpoints such as fetching doctors,
 * booking appointments, and cancelling appointments.
 */
class PatientRepository {
  final ApiClient _apiClient = ApiClient();

  /**
   * @brief Books an appointment for the current patient.
   * 
   * @param doctorId The unique identifier of the doctor.
   * @param date The date of the appointment (e.g., "2025-04-20").
   * @param dayOfWeek The day of the week (e.g., "monday").
   * @param frameStart The start time of the slot (e.g., "09:00").
   * @param frameEnd The end time of the slot (e.g., "14:00").
   * @return A map containing the booked appointment details.
   */
  Future<Map<String, dynamic>> bookAppointment({
    required String doctorId,
    required String date,
    required String dayOfWeek,
    required String frameStart,
    required String frameEnd,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/patients/appointments/book',
        data: {
          'doctorId': doctorId,
          'date': date,
          'dayOfWeek': dayOfWeek,
          'frameStart': frameStart,
          'frameEnd': frameEnd,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to book appointment: $e');
    }
  }

  /**
   * @brief Fetches all appointments for the current patient.
   * 
   * @return A list of Appointment objects.
   */
  Future<List<Appointment>> getAppointments() async {
    try {
      final response = await _apiClient.dio.get('/patients/appointments');
      final list = response.data['appointments'] as List<dynamic>? ?? [];
      return list.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch appointments: $e');
    }
  }

  /**
   * @brief Cancels an existing appointment.
   * 
   * @param appointmentId The ID of the appointment to cancel.
   * @return True if successful, false otherwise.
   */
  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final response = await _apiClient.dio.delete('/patients/appointments/$appointmentId');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to cancel appointment: $e');
    }
  }
}
