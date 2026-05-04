import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/models/appointment.dart';
import '../../../../core/models/doctor.dart';

/**
 * Repository for interacting with the backend Patient API.
 * Handles fetching doctors, booking, and cancelling appointments.
 */
class PatientRepository {
  final ApiClient _apiClient = ApiClient();

  /**
   * Books an appointment for the current patient.
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
   * Fetches all appointments for the current patient.
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
   * Cancels an existing appointment.
   */
  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final response = await _apiClient.dio.delete('/patients/appointments/$appointmentId');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to cancel appointment: $e');
    }
  }

  /**
   * Fetches all available doctors from the platform.
   */
  Future<List<Doctor>> getAllDoctors() async {
    try {
      final response = await _apiClient.dio.get('/patients/doctors');
      final list = response.data['doctors'] as List<dynamic>? ?? [];
      return list.map((e) => Doctor.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  /**
   * Fetches doctors filtered by a specific department name.
   */
  Future<List<Doctor>> getDoctorsByDepartment(String departmentName) async {
    try {
      final response = await _apiClient.dio.get('/patients/departments/$departmentName');
      final list = response.data['doctors'] as List<dynamic>? ?? [];
      return list.map((e) => Doctor.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch doctors for department: $e');
    }
  }

  /**
   * Fetches the weekly schedule for a specific doctor.
   */
  Future<dynamic> getDoctorSchedule(String doctorId) async {
    try {
      final response = await _apiClient.dio.get('/patients/doctors/$doctorId/schedule');
      return response.data['availability'] ?? {};
    } catch (e) {
      throw Exception('Failed to fetch doctor schedule: $e');
    }
  }
}
