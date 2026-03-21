import 'package:flutter/material.dart';

class TimeSlot {
  TimeOfDay start;
  TimeOfDay end;
  TimeSlot({required this.start, required this.end});


  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    final startParts = (json['start'] as String).split(':');
    final endParts = (json['end'] as String).split(':');

    return TimeSlot(
      start: TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1]),
      ),
      end: TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1]),
      ),
    );
  }
}
