import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/doctor.dart';
import '../../../../core/widgets/backward_button.dart';
import '../../../../core/widgets/doctor_card.dart';
import '../../../../core/widgets/error_placeholder.dart';
import '../../../../core/widgets/header_text.dart';
import '../../../booking/providers/patient_repository_provider.dart';
import '../../../booking/view/screens/doctor_booking_screen.dart';

/**
 * A screen that allows patients to search for doctors and clinics.
 * Fetches data live from the API.
 */
class SearchScreen extends ConsumerStatefulWidget {
  final String query;

  const SearchScreen({super.key, this.query = ""});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late Future<List<Doctor>> _doctorsFuture;
  String _searchQuery = "";
  String _sortBy = "Recommended";

  @override
  void initState() {
    super.initState();
    _doctorsFuture = ref.read(patientRepositoryProvider).getAllDoctors();
    _searchQuery = widget.query;
  }

  void _retry() {
    setState(() {
      _doctorsFuture = ref.read(patientRepositoryProvider).getAllDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackWardButton(),
        centerTitle: true,
        title: HeaderText(
          text: "Find Care",
          fontsize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Divider(height: 1.h, color: const Color(0XFFe2e8f0)),
            SizedBox(height: 16.h),

            // Search Bar
            Container(
              width: double.infinity,
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  width: 2.w,
                  color: const Color(0XFFf8fafc),
                ),
              ),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search doctors, clinics, or specialty",
                  hintStyle: TextStyle(color: const Color(0XFF64748b), fontSize: 14.sp),
                  prefixIcon: Icon(Icons.search, color: const Color(0XFF64748b), size: 25.r),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                ),
              ),
            ),

            SizedBox(height: 24.h),
            
            // Header & Sort Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderText(text: "Suggested Doctors", fontsize: 18.sp),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: DropdownButton<String>(
                    value: _sortBy,
                    icon: Icon(Icons.sort, size: 18.r, color: const Color(0xFF334155)),
                    elevation: 16,
                    style: TextStyle(color: const Color(0xFF334155), fontSize: 14.sp, fontWeight: FontWeight.w500),
                    underline: const SizedBox(),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _sortBy = value;
                        });
                      }
                    },
                    items: [
                      "Recommended", 
                      "Rating: High to Low", 
                      "Rating: Low to High",
                      "Patients: High to Low",
                      "Patients: Low to High",
                      "Experience: High to Low",
                      "Experience: Low to High"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: FutureBuilder<List<Doctor>>(
                future: _doctorsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return ErrorPlaceholder(
                      message: 'Unable to load doctors',
                      error: snapshot.error,
                      stackTrace: snapshot.stackTrace,
                      onRetry: _retry,
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No doctors found."));
                  }

                  // Clone the list so we can sort and filter safely
                  var doctors = List<Doctor>.from(snapshot.data!);

                  // Client-side Filtering
                  if (_searchQuery.isNotEmpty) {
                    final q = _searchQuery.toLowerCase();
                    doctors = doctors.where((d) => 
                      d.name.toLowerCase().contains(q) || 
                      d.department.toLowerCase().contains(q) || 
                      d.clinicName.toLowerCase().contains(q)
                    ).toList();
                  }

                  // Client-side Sorting
                  if (_sortBy == "Rating: High to Low") {
                    doctors.sort((a, b) => b.rating.compareTo(a.rating));
                  } else if (_sortBy == "Rating: Low to High") {
                    doctors.sort((a, b) => a.rating.compareTo(b.rating));
                  } else if (_sortBy == "Patients: High to Low") {
                    doctors.sort((a, b) => b.patients.compareTo(a.patients));
                  } else if (_sortBy == "Patients: Low to High") {
                    doctors.sort((a, b) => a.patients.compareTo(b.patients));
                  } else if (_sortBy == "Experience: High to Low") {
                    doctors.sort((a, b) => b.expYears.compareTo(a.expYears));
                  } else if (_sortBy == "Experience: Low to High") {
                    doctors.sort((a, b) => a.expYears.compareTo(b.expYears));
                  }

                  if (doctors.isEmpty) {
                    return Center(
                      child: Text(
                        "No matches found for '$_searchQuery'",
                        style: TextStyle(color: const Color(0xFF64748B), fontSize: 15.sp),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: 24.h),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: DoctorCard(
                          doctor: doctor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorBookingScreen(
                                  doctor: doctor,
                                  schedule: const [],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}