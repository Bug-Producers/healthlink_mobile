import 'package:intl/intl.dart';

class Doctor {
  final String uuid;
  final String name;
  final String department;
  final String city;
  final String country;
  final String clinicName;
  final double rating;
  final int expYears;
  final int patients;
  final String about;
  final String profileImage;

  Doctor({
    required this.uuid,
    required this.name,
    required this.department,
    required this.city,
    required this.country,
    required this.clinicName,
    required this.rating,
    required this.expYears,
    required this.patients,
    required this.about,
    required this.profileImage,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    // Helper to safely extract string, even if it's an object with a 'name' field
    String safeString(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      if (value is Map && value.containsKey('name')) return value['name'].toString();
      return value.toString();
    }

    return Doctor(
      uuid: safeString(json['uuid']),
      name: safeString(json['name']),
      department: safeString(json['department']),
      city: safeString(json['city']),
      country: safeString(json['country']),
      clinicName: safeString(json['hospitalOrClinicName']),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      expYears: json['expYears'] ?? 0,
      patients: json['patients'] ?? 0,
      about: safeString(json['about']),
      profileImage: safeString(json['profileImage']),
    );
  }

  String patientsFormatted() {
    final f = NumberFormat.decimalPattern();
    return f.format(patients);
  }}