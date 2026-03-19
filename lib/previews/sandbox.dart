import 'package:flutter/material.dart';
import 'package:healthlink_mobile/view/widgets/doctor_card.dart';

import '../models/doctor.dart';

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    final mockDoctor = Doctor(
      uuid: '12345',
      name: 'Dr. Jane Smith',
      city: 'London',
      country: 'UK',
      department: "testing",
      clinicName: 'St. Mary\'s Hospital',
      rating: 4.8,
      expYears: 12,
      patients: 1200,
      about: 'Specialist in cardiology with over a decade of experience.',
      profileImage: 'https://sis.ecu.edu.eg/Files/UserImages/192400676_20240910142333.jpg',
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DoctorCard(doctor: mockDoctor),
        ),
      ),
    );
  }
}