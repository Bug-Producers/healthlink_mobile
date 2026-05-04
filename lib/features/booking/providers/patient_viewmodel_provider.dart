import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/patient_viewmodel.dart';

final patientViewModelProvider =
    AsyncNotifierProvider<PatientViewModel, Map<String, dynamic>?>(
  PatientViewModel.new,
);
