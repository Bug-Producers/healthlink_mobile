import 'package:flutter/material.dart';

class AvailabilityWindow {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  AvailabilityWindow({
    required this.startTime,
    required this.endTime,
  });

  factory AvailabilityWindow.fromJson(Map<String, dynamic> json) {
    final startParts = (json['startTime'] as String).split(':');
    final endParts = (json['endTime'] as String).split(':');

    return AvailabilityWindow(
      startTime: TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1]),
      ),
    );
  }
}

class DoctorScheduleComplete {
  final String doctorId;
  final int appointmentDuration;
  final int bufferTime;
  final Map<String, List<AvailabilityWindow>> availability;

  DoctorScheduleComplete({
    required this.doctorId,
    required this.appointmentDuration,
    required this.bufferTime,
    required this.availability,
  });

  factory DoctorScheduleComplete.fromJson(Map<String, dynamic> json) {
    final availabilityMap = json['availability'] as Map<String, dynamic>? ?? {};
    final Map<String, List<AvailabilityWindow>> parsedAvailability = {};

    availabilityMap.forEach((day, windows) {
      final windowList = windows as List<dynamic>? ?? [];
      parsedAvailability[day] = windowList
          .map((e) => AvailabilityWindow.fromJson(e as Map<String, dynamic>))
          .toList();
    });

    return DoctorScheduleComplete(
      doctorId: json['doctorId'] ?? '',
      appointmentDuration: json['appointmentDuration'] ?? 30,
      bufferTime: json['bufferTime'] ?? 0,
      availability: parsedAvailability,
    );
  }
}
