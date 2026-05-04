import 'package:flutter/material.dart';
import 'package:healthlink_mobile/features/auth/view/screens/login_screen.dart';
import '../core/models/day.dart';
import '../core/models/day_schedule.dart';
import '../core/models/doctor.dart';
import '../core/models/time_slot.dart';
import '../features/booking/view/screens/search_by_category_screen.dart';
import '../features/auth/view/screens/search_screen.dart';
import '../features/booking/view/screens/doctor_booking_screen.dart';



class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Doctor> doctors = [
      Doctor(
        uuid: "1",
        name: "Dr. Sarah Ahmed",
        department: "Cardiology",
        city: "Cairo",
        country: "Egypt",
        clinicName: "Heart Care Clinic",
        rating: 4.8,
        expYears: 12,
        patients: 1500,
        about: "Experienced cardiologist specializing in heart diseases.",
        profileImage: "https://randomuser.me/api/portraits/women/44.jpg",
      ),
      Doctor(
        uuid: "2",
        name: "Dr. Mohamed Hassan",
        department: "Dermatology",
        city: "Alexandria",
        country: "Egypt",
        clinicName: "Skin Health Center",
        rating: 4.5,
        expYears: 9,
        patients: 980,
        about: "Focused on treating skin conditions with modern techniques.",
        profileImage: "https://randomuser.me/api/portraits/men/32.jpg",
      ),
      Doctor(
        uuid: "3",
        name: "Dr. Nour ElDin",
        department: "Orthopedics",
        city: "Giza",
        country: "Egypt",
        clinicName: "Bone & Joint Clinic",
        rating: 4.7,
        expYears: 15,
        patients: 2000,
        about: "Specialist in bone injuries and joint replacement.",
        profileImage: "https://randomuser.me/api/portraits/men/65.jpg",
      ),
      Doctor(
        uuid: "4",
        name: "Dr. Lina Mostafa",
        department: "Pediatrics",
        city: "Cairo",
        country: "Egypt",
        clinicName: "Kids Care Clinic",
        rating: 4.9,
        expYears: 10,
        patients: 1700,
        about: "Dedicated pediatrician providing care for children.",
        profileImage: "https://randomuser.me/api/portraits/women/68.jpg",
      ),
      Doctor(
        uuid: "5",
        name: "Dr. Omar Khaled",
        department: "Neurology",
        city: "Mansoura",
        country: "Egypt",
        clinicName: "Neuro Health Center",
        rating: 4.6,
        expYears: 11,
        patients: 1200,
        about: "Treats neurological disorders with a patient-focused approach.",
        profileImage: "https://randomuser.me/api/portraits/men/12.jpg",
      ),
    ];

    return const SearchByCategoryScreen(departmentName: "Cardiology");  }  }
