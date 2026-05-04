import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/models/appointment.dart';
import '../../../../core/models/doctor.dart';
import '../../../../core/models/doctor_schedule_complete.dart';

/**
 * Repository for interacting with the backend Patient API.
 * Handles fetching doctors, booking, and cancelling appointments.
 */
class PatientRepository {
  final ApiClient _apiClient = ApiClient();

  // ---------------------------------------------------------------------------
  // Profile Management
  // ---------------------------------------------------------------------------

  Future<Map<String, dynamic>> getPatientProfile(String patientId) async {
    try {
      final response = await _apiClient.dio.get('/patients/$patientId');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch patient profile: $e');
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.put('/patients/profile', data: data);
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<bool> updateProfileImage(String base64Image) async {
    try {
      final response = await _apiClient.dio.put(
        '/patients/profile/image',
        data: {'image': base64Image},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update profile image: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Doctor Discovery
  // ---------------------------------------------------------------------------

  Future<List<Doctor>> getAllDoctors() async {
    try {
      final response = await _apiClient.dio.get('/patients/doctors');
      final list = response.data['doctors'] as List<dynamic>? ?? [];
      return list.map((e) => Doctor.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  Future<Doctor> getDoctorProfile(String doctorId) async {
    try {
      final response = await _apiClient.dio.get('/patients/doctors/$doctorId');
      return Doctor.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch doctor profile: $e');
    }
  }

  Future<List<Doctor>> getDoctorsByDepartment(String departmentName) async {
    try {
      final response = await _apiClient.dio.get('/patients/departments/$departmentName');
      final list = response.data['doctors'] as List<dynamic>? ?? [];
      return list.map((e) => Doctor.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch doctors for department: $e');
    }
  }

  Future<List<dynamic>> getDoctorSchedule(String doctorId, [String? day]) async {
    try {
      // Provide a fallback day if none is specified or use the original logic
      final targetDay = day ?? 'Monday';
      final response = await _apiClient.dio.get('/patients/doctors/$doctorId/slots/$targetDay');
      return response.data['slots'] as List<dynamic>? ?? [];
    } catch (e) {
      throw Exception('Failed to fetch doctor slots: $e');
    }
  }

  Future<DoctorScheduleComplete> getDoctorScheduleComplete(String doctorId) async {
    try {
      final response = await _apiClient.dio.get('/patients/doctors/$doctorId/schedule');
      return DoctorScheduleComplete.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch complete doctor schedule: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Appointments
  // ---------------------------------------------------------------------------

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

  Future<List<Appointment>> getAppointments() async {
    try {
      final response = await _apiClient.dio.get('/patients/appointments');
      final list = response.data['appointments'] as List<dynamic>? ?? [];
      return list.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 400) {
        return [];
      }
      throw Exception('Failed to fetch appointments: $e');
    } catch (e) {
      throw Exception('Failed to fetch appointments: $e');
    }
  }

  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final response = await _apiClient.dio.delete('/patients/appointments/$appointmentId');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to cancel appointment: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Ratings & History
  // ---------------------------------------------------------------------------

  Future<bool> rateDoctor({
    required String doctorId,
    required int stars,
    required String comment,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/patients/ratings',
        data: {
          'doctorId': doctorId,
          'stars': stars,
          'comment': comment,
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to rate doctor: $e');
    }
  }

  Future<List<dynamic>> getHistory({String? patientId}) async {
    try {
      final queryParams = patientId != null ? {'patientId': patientId} : null;
      final response = await _apiClient.dio.get(
        '/patients/history',
        queryParameters: queryParams,
      );
      return response.data['history'] as List<dynamic>? ?? [];
    } catch (e) {
      throw Exception('Failed to fetch history: $e');
    }
  }

  Future<bool> addHistoryReport({
    required String patientId,
    required String report,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/patients/history',
        data: {
          'patientId': patientId,
          'report': report,
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to add history report: $e');
    }
  }

  Future<List<dynamic>> getNotifications() async {
    try {
      final response = await _apiClient.dio.get('/patients/notifications');
      return response.data['notifications'] as List<dynamic>? ?? [];
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }
}
