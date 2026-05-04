import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/doctor.dart';
import '../../../../core/widgets/backward_button.dart';
import '../../../../core/widgets/doctor_card.dart';
import '../../../../core/widgets/header_text.dart';
import '../../providers/patient_repository_provider.dart';
import 'doctor_booking_screen.dart';

/**
 * Displays a list of doctors filtered by the selected department.
 * Fetches data live from the API.
 */
class SearchByCategoryScreen extends ConsumerWidget {
  final String departmentName;

  const SearchByCategoryScreen({super.key, required this.departmentName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(patientRepositoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackWardButton(),
        centerTitle: true,
        title: HeaderText(
          text: departmentName.isEmpty ? "Find Care" : departmentName,
          fontsize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Doctor>>(
          future: departmentName.isEmpty ? repo.getAllDoctors() : repo.getDoctorsByDepartment(departmentName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error fetching doctors: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No doctors found."));
            }

            final doctors = snapshot.data!;

            return Padding(
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
                        // Filtering logic can go here
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

                  SizedBox(height: 32.h),
                  HeaderText(text: "Suggested Doctors", fontsize: 18.sp),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: ListView.builder(
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
                                    schedule: const [], // TODO: Fetch real schedule or pass from doctor model if available
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
