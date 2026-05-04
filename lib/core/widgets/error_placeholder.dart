import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_logger.dart';

/**
 * A reusable error placeholder widget.
 *
 * Logs the actual error to the debug console via [AppLogger] and displays
 * a user-friendly message with a refresh button so the user can retry.
 */
class ErrorPlaceholder extends StatelessWidget {
  /// A short, user-facing message shown above the refresh button.
  final String message;

  /// The actual error object — logged to the debug console, never shown in UI.
  final Object? error;

  /// The stack trace — logged alongside the error.
  final StackTrace? stackTrace;

  /// Callback invoked when the user taps the refresh button.
  final VoidCallback onRetry;

  const ErrorPlaceholder({
    super.key,
    this.message = 'Something went wrong',
    this.error,
    this.stackTrace,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // Log the real error to the debug console so developers can diagnose.
    if (error != null) {
      AppLogger.error(
        message,
        error: error,
        stackTrace: stackTrace,
        name: 'ErrorPlaceholder',
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error icon
            Container(
              height: 72.h,
              width: 72.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                color: const Color(0xFFEF4444),
                size: 36.r,
              ),
            ),
            SizedBox(height: 20.h),

            // User-friendly message
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
            ),
            SizedBox(height: 8.h),

            // Subtitle
            Text(
              'Please check your connection and try again',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF94A3B8),
              ),
            ),
            SizedBox(height: 24.h),

            // Refresh button
            SizedBox(
              width: 180.w,
              height: 48.h,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh_rounded, size: 20.r),
                label: Text(
                  'Refresh',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF135bec),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
