import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/header_text.dart';

/**
 * A premium-looking bottom sheet dialog for rating a doctor after a completed appointment.
 */
class RateDoctorSheet extends StatefulWidget {
  final String doctorName;
  final String? doctorImage;
  final Future<bool> Function(int stars, String comment) onSubmit;

  const RateDoctorSheet({
    super.key,
    required this.doctorName,
    this.doctorImage,
    required this.onSubmit,
  });

  @override
  State<RateDoctorSheet> createState() => _RateDoctorSheetState();
}

class _RateDoctorSheetState extends State<RateDoctorSheet> {
  int _selectedStars = 0;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),

            // Title
            HeaderText(text: "Rate Your Experience", fontsize: 20.sp),
            SizedBox(height: 8.h),

            Text(
              "How was your visit with Dr. ${widget.doctorName}?",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 24.h),

            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                return GestureDetector(
                  onTap: () => setState(() => _selectedStars = starIndex),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: AnimatedScale(
                      scale: _selectedStars >= starIndex ? 1.2 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        _selectedStars >= starIndex
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: _selectedStars >= starIndex
                            ? const Color(0xFFFACC15)
                            : const Color(0xFFCBD5E1),
                        size: 40.r,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 8.h),

            // Rating label
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                _getRatingLabel(),
                key: ValueKey(_selectedStars),
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF135BEC),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Comment field
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Share your experience (optional)...",
                hintStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF94A3B8),
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFF135BEC), width: 1.5),
                ),
                contentPadding: EdgeInsets.all(16.w),
              ),
            ),
            SizedBox(height: 24.h),

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _selectedStars == 0 || _isSubmitting
                    ? null
                    : _submitRating,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF135BEC),
                  disabledBackgroundColor: const Color(0xFFCBD5E1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? SizedBox(
                        width: 24.r,
                        height: 24.r,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Submit Rating",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRatingLabel() {
    switch (_selectedStars) {
      case 1:
        return "Poor";
      case 2:
        return "Fair";
      case 3:
        return "Good";
      case 4:
        return "Very Good";
      case 5:
        return "Excellent!";
      default:
        return "Tap a star to rate";
    }
  }

  Future<void> _submitRating() async {
    setState(() => _isSubmitting = true);
    try {
      final success = await widget.onSubmit(
        _selectedStars,
        _commentController.text.trim(),
      );
      if (mounted) {
        Navigator.pop(context, success);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit rating: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
