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
 * Displays a list of doctors filtered by the selected department.
 * Fetches data live from the API.
 */
class SearchByCategoryScreen extends ConsumerStatefulWidget {
  final String departmentName;

  const SearchByCategoryScreen({super.key, required this.departmentName});

  @override
  ConsumerState<SearchByCategoryScreen> createState() => _SearchByCategoryScreenState();
}

class _SearchByCategoryScreenState extends ConsumerState<SearchByCategoryScreen> {
  late Future<List<Doctor>> _doctorsFuture;

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  void _loadDoctors() {
    final repo = ref.read(patientRepositoryProvider);
    _doctorsFuture = repo.getDoctorsByDepartment(widget.departmentName);
  }

  void _retry() {
    setState(() {
      _loadDoctors();
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
          text: widget.departmentName,
          fontsize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
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
              return Center(child: Text("No doctors found for ${widget.departmentName}."));
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
                  HeaderText(text: "Suggested Doctors", fontsize: 18.sp),
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
                                    schedule: const [], 
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