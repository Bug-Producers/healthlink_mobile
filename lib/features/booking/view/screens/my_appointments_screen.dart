import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/header_text.dart';
import '../../../../core/widgets/error_placeholder.dart';
import '../../../../core/models/appointment.dart';
import '../../providers/appointments_viewmodel_provider.dart';
import '../../providers/patient_repository_provider.dart';
import '../../../../core/utils/image_helper.dart';
import '../widgets/rate_doctor_sheet.dart';

/**
 * A screen that displays the patient's booked appointments.
 * This screen fetches appointments from the backend via the AppointmentsViewModel
 * and allows the patient to cancel any existing appointment.
 */
class MyAppointmentsScreen extends ConsumerWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsState = ref.watch(appointmentsViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: HeaderText(text: "My Appointments", fontsize: 18.sp),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(appointmentsViewModelProvider.notifier).refresh();
            },
          )
        ],
      ),
      body: appointmentsState.when(
        data: (appointments) {
          if (appointments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month_outlined, size: 64.r, color: const Color(0xFFCBD5E1)),
                  SizedBox(height: 16.h),
                  Text(
                    "No upcoming appointments",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appt = appointments[index];
              return _AppointmentCard(
                appointment: appt,
                onCancel: () async {
                  try {
                    await ref
                        .read(appointmentsViewModelProvider.notifier)
                        .cancelAppointment(appt.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Appointment cancelled.')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to cancel: $e')),
                      );
                    }
                  }
                },
                onRate: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => RateDoctorSheet(
                      doctorName: appt.doctorName ?? "Doctor",
                      doctorImage: appt.doctorImage,
                      onSubmit: (stars, comment) async {
                        final repo = ref.read(patientRepositoryProvider);
                        final success = await repo.rateDoctor(
                          doctorId: appt.doctorId,
                          stars: stars,
                          comment: comment,
                        );
                        if (context.mounted && success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Thanks for your rating!')),
                          );
                        }
                        return success;
                      },
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => ErrorPlaceholder(
          message: 'Unable to load appointments',
          error: err,
          stackTrace: stack,
          onRetry: () {
            ref.read(appointmentsViewModelProvider.notifier).refresh();
          },
        ),
      ),
    );
  }
}

/**
 * A card widget displaying appointment details.
 */
class _AppointmentCard extends StatelessWidget {
  /**
   * appointment The typed Appointment model.
   * onCancel The callback triggered when the cancel button is pressed.
   * onRate The callback triggered when the rate button is pressed.
   */
  final Appointment appointment;
  final VoidCallback onCancel;
  final VoidCallback onRate;

  const _AppointmentCard({
    required this.appointment,
    required this.onCancel,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    // Determine status text based on enum/int from backend
    // Typically: 0=Booked, 1=Completed, 2=Cancelled
    final statusInt = appointment.status;
    String statusStr = "Booked";
    Color statusColor = const Color(0XFF135bec);
    
    if (statusInt == 1) {
      statusStr = "Completed";
      statusColor = Colors.green;
    } else if (statusInt == 2) {
      statusStr = "Cancelled";
      statusColor = Colors.red;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date: ${appointment.date}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  statusStr,
                  style: TextStyle(color: statusColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              if (appointment.doctorImage != null && appointment.doctorImage!.isNotEmpty)
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: ImageHelper.getImageProvider(appointment.doctorImage!),
                )
              else
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: const Color(0XFF135bec).withOpacity(0.1),
                  child: Icon(Icons.person, color: const Color(0XFF135bec), size: 20.r),
                ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName ?? "Doctor",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    Text(
                      "Date: ${appointment.date}",
                      style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            "Time: ${appointment.startTime} - ${appointment.endTime}",
            style: TextStyle(fontSize: 14.sp, color: Colors.black54),
          ),
          SizedBox(height: 16.h),
          
          if (statusInt == 0) // Only show cancel if currently booked
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onCancel,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: const Text("Cancel Appointment"),
              ),
            ),
          
          if (statusInt == 1) // Show rate button for completed appointments
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRate,
                icon: const Icon(Icons.star_rounded, color: Colors.white),
                label: const Text("Rate Doctor"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF135BEC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


