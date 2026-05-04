import '../../../../core/api/api_client.dart';
import '../../../../core/models/appointment.dart';

/**
 * Repository for interacting with the backend Doctor API.
 */
class DoctorRepository {
  final ApiClient _apiClient = ApiClient();

  // ---------------------------------------------------------------------------
  // Profile Management
  // ---------------------------------------------------------------------------

  Future<bool> register({
    required String name,
    required String city,
    required String country,
    required String clinicName,
    required String about,
    required String department,
    required int expYears,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/doctors/register',
        data: {
          'name': name,
          'city': city,
          'country': country,
          'hospitalOrClinicName': clinicName,
          'about': about,
          'department': department,
          'expYears': expYears,
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to register doctor: $e');
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _apiClient.dio.get('/doctors/profile');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch doctor profile: $e');
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.put('/doctors/profile', data: data);
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<bool> updateProfileImage(String base64Image) async {
    try {
      final response = await _apiClient.dio.put(
        '/doctors/profile/image',
        data: {'image': base64Image},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update profile image: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Schedule Management
  // ---------------------------------------------------------------------------

  Future<Map<String, dynamic>> getSchedule() async {
    try {
      final response = await _apiClient.dio.get('/doctors/schedule');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch schedule: $e');
    }
  }

  Future<bool> updateSchedule(Map<String, dynamic> schedule) async {
    try {
      final response = await _apiClient.dio.put('/doctors/schedule', data: schedule);
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update schedule: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Appointments Management
  // ---------------------------------------------------------------------------

  Future<List<Appointment>> getAppointments() async {
    try {
      final response = await _apiClient.dio.get('/doctors/appointments');
      final list = response.data['appointments'] as List<dynamic>? ?? [];
      return list.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch appointments: $e');
    }
  }

  Future<bool> updateAppointmentStatus(String appointmentId, int status) async {
    try {
      final response = await _apiClient.dio.patch(
        '/doctors/appointments/$appointmentId',
        data: {'status': status},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update appointment status: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Payments & Revenue
  // ---------------------------------------------------------------------------

  Future<bool> registerPayment({
    required String appointmentId,
    required double amount,
    required String paymentMethod,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/doctors/payments',
        data: {
          'appointmentId': appointmentId,
          'amount': amount,
          'paymentMethod': paymentMethod,
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to register payment: $e');
    }
  }

  Future<List<dynamic>> getPayments() async {
    try {
      final response = await _apiClient.dio.get('/doctors/payments');
      return response.data['payments'] as List<dynamic>? ?? [];
    } catch (e) {
      throw Exception('Failed to fetch payments: $e');
    }
  }

  Future<Map<String, dynamic>> getRevenue() async {
    try {
      final response = await _apiClient.dio.get('/doctors/revenue');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch revenue: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Ratings
  // ---------------------------------------------------------------------------

  Future<List<dynamic>> getRatings() async {
    try {
      final response = await _apiClient.dio.get('/doctors/ratings');
      return response.data['ratings'] as List<dynamic>? ?? [];
    } catch (e) {
      throw Exception('Failed to fetch ratings: $e');
    }
  }
}
