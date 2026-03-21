import 'package:flutter/material.dart';
import '../core/models/day.dart';
import '../core/models/day_schedule.dart';
import '../core/models/doctor.dart';
import '../core/models/time_slot.dart';
import '../features/booking/view/screens/doctor_booking_screen.dart';



class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {


    final List<DaySchedule> mockSchedule = [
      DaySchedule(
        number: 9,
        day: Day.MON,
        slots: [
          TimeSlot(
            start: const TimeOfDay(hour: 9, minute: 0),
            end: const TimeOfDay(hour: 10, minute: 0),
          ),
          TimeSlot(
            start: const TimeOfDay(hour: 10, minute: 30),
            end: const TimeOfDay(hour: 11, minute: 30),
          ),
        ],
      ),
      DaySchedule(
        number: 10,

        day: Day.TUE,
        slots: [
          TimeSlot(
            start: const TimeOfDay(hour: 12, minute: 0),
            end: const TimeOfDay(hour: 13, minute: 0),
          ),
          TimeSlot(
            start: const TimeOfDay(hour: 14, minute: 0),
            end: const TimeOfDay(hour: 15, minute: 0),
          ),
        ],
      ),
      DaySchedule(
        number: 11,

        day: Day.WED,
        slots: [
          TimeSlot(
            start: const TimeOfDay(hour: 9, minute: 30),
            end: const TimeOfDay(hour: 10, minute: 30),
          ),
        ],
      ),
      DaySchedule(
        number: 12,

        day: Day.THU,
        slots: [
          TimeSlot(
            start: const TimeOfDay(hour: 16, minute: 0),
            end: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      ),
      DaySchedule(
        number: 13,
        day: Day.FRI,
        slots: [
          TimeSlot(
            start: const TimeOfDay(hour: 11, minute: 0),
            end: const TimeOfDay(hour: 12, minute: 0),
          ),
          TimeSlot(
            start: const TimeOfDay(hour: 13, minute: 0),
            end: const TimeOfDay(hour: 14, minute: 0),
          ),
        ],
      ),
    ];

    final doctor = Doctor(
      uuid: "1",
      name: "Mohamed Badawy",
      department: "Kids",
      city: "Cairo",
      country: "Egypt",
      clinicName: "Fun Clinic",
      rating: 4.8,
      expYears: 10,
      patients: 140000,
      about: "Experienced cardiologist",
      profileImage: "https://sis.ecu.edu.eg/Files/UserImages/192400676_20240910142333.jpg",
    );

    return DoctorBookingScreen(
      doctor: doctor,
      schedule: mockSchedule,
    );  }  }
