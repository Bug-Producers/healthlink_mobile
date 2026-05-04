/**
 * Represents a patient's appointment.
 */
class Appointment {
  final String id;
  final String doctorId;
  final String? doctorName;
  final String? doctorImage;
  final String date;
  final String startTime;
  final String endTime;
  final int duration;
  final int status;

  /**
   * id Unique identifier of the appointment.
   * doctorId The doctor's ID.
   * doctorName The doctor's full name.
   * doctorImage The doctor's profile image URL.
   * date Date of the appointment.
   * startTime Start time (HH:MM).
   * endTime End time (HH:MM).
   * duration Duration in minutes.
   * status Status of the appointment (0=Booked, 1=Completed, 2=Cancelled).
   */
  Appointment({
    required this.id,
    required this.doctorId,
    this.doctorName,
    this.doctorImage,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.status,
  });

  /**
   * Factory constructor to create an Appointment from JSON.
   */
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String? ?? '',
      doctorId: json['doctorId'] as String? ?? '',
      doctorName: json['doctorName'] as String?,
      doctorImage: json['doctorImage'] as String?,
      date: json['date'] as String? ?? '',
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
    );
  }
}
