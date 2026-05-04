import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/booking_viewmodel.dart';

/**
 * Provider for the BookingViewModel.
 */
final bookingViewModelProvider =
    AsyncNotifierProvider<BookingViewModel, void>(
  BookingViewModel.new,
);
