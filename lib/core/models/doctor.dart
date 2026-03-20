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
    return Doctor(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      department: json['department'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      clinicName: json['hospitalOrClinicName'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      expYears: json['expYears'] ?? 0,
      patients: json['patients'] ?? 0,
      about: json['about'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }
}