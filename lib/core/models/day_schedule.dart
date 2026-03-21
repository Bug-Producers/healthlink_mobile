import 'package:healthlink_mobile/core/models/time_slot.dart';

import 'day.dart';

class DaySchedule {
  final Day day;
  final int number;
  final List<TimeSlot> slots;

    DaySchedule({
    required this.day,
    required this.number,
    required this.slots,
  });

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    return DaySchedule(
      day: Day.values.firstWhere(
            (e) => e.name == json['day'],
      ),
      slots: (json['slots'] as List)
          .map((e) => TimeSlot.fromJson(e))
          .toList(), number: 12,
    );
  }
}