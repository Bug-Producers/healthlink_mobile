import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/header_text.dart';
import '../../../booking/providers/appointments_viewmodel_provider.dart';
import '../../../../core/utils/image_helper.dart';

/**
 * A widget that displays the patient's next upcoming appointment on the home screen.
 * It listens to the appointmentsViewModelProvider and shows the nearest appointment with status == 0.
 * If no upcoming appointments exist, it returns a shrunk SizedBox.
 */
class UpcomingAppointmentWidget extends ConsumerWidget {
  const UpcomingAppointmentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsState = ref.watch(appointmentsViewModelProvider);

    return appointmentsState.maybeWhen(
      data: (appointments) {
        // Filter for booked appointments (status == 0)
        final upcomingAppts = appointments.where((a) => a.status == 0).toList();
        
        if (upcomingAppts.isEmpty) {
          return const SizedBox.shrink();
        }

        // Sort by date/time to get the nearest one.
        // Assuming date is "YYYY-MM-DD" and startTime is "HH:MM"
        upcomingAppts.sort((a, b) {
          final aDateTimeStr = "${a.date} ${a.startTime}";
          final bDateTimeStr = "${b.date} ${b.startTime}";
          return aDateTimeStr.compareTo(bDateTimeStr);
        });

        final nextAppt = upcomingAppts.first;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 333.w,
                child: HeaderText(
                  text: "Upcoming Appointment",
                  fontsize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: 333.w,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0XFF135bec),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0XFF135bec).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (nextAppt.doctorImage != null && nextAppt.doctorImage!.isNotEmpty)
                          CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.white,
                            backgroundImage: ImageHelper.getImageProvider(nextAppt.doctorImage!),
                          )
                        else
                          CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: const Color(0XFF135bec), size: 24.r),
                          ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nextAppt.doctorName ?? "Doctor",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "HealthLink Professional",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_rounded, color: Colors.white, size: 18.r),
                          SizedBox(width: 8.w),
                          Text(
                            nextAppt.date,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.access_time_rounded, color: Colors.white, size: 18.r),
                          SizedBox(width: 8.w),
                          Text(
                            "${nextAppt.startTime} - ${nextAppt.endTime}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
