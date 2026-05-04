import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/doctor_viewmodel.dart';

final doctorViewModelProvider =
    AsyncNotifierProvider<DoctorViewModel, Map<String, dynamic>?>(
  DoctorViewModel.new,
);
