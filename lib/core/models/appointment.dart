/**
 * @brief Represents a patient's appointment.
 */
class Appointment {
  final String id;
  final String doctorId;
  final String date;
  final String startTime;
  final String endTime;
  final int duration;
  final int status;

  /**
   * @param id Unique identifier of the appointment.
   * @param doctorId The doctor's ID.
   * @param date Date of the appointment.
   * @param startTime Start time (HH:MM).
   * @param endTime End time (HH:MM).
   * @param duration Duration in minutes.
   * @param status Status of the appointment (0=Booked, 1=Completed, 2=Cancelled).
   */
  Appointment({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.status,
  });

  /**
   * @brief Factory constructor to create an Appointment from JSON.
   */
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String? ?? '',
      doctorId: json['doctorId'] as String? ?? '',
      date: json['date'] as String? ?? '',
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
    );
  }
}
