import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/appointment.dart';
import '../viewmodel/appointments_viewmodel.dart';

/**
 * Provider for the AppointmentsViewModel.
 */
final appointmentsViewModelProvider =
    AsyncNotifierProvider<AppointmentsViewModel, List<Appointment>>(
  AppointmentsViewModel.new,
);
