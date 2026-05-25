import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RejectionDialogHelper {
  static void show({
    required BuildContext context,
    required TextEditingController controller,
    required void Function(BrandStatus, String?) onStatusChange,
    VoidCallback? onConfirm,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) => Container(),
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: anim1,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
            title: Row(
              children: [
                Icon(Icons.error_outline, color: const Color(0xFFE11D48), size: 28.sp),
                SizedBox(width: 12.w),
                Text(
                  "Reject Request",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please provide a clear reason for rejecting this brand registration.",
                  style: TextStyle(fontSize: 14.sp, color: const Color(0xFF64748B)),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: controller,
                  maxLines: 4,
                  autofocus: true,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: "e.g., Logo is blurry, low-quality products...",
                    hintStyle: TextStyle(color: const Color(0xFF94A3B8), fontSize: 13.sp),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(16.r),
                  ),
                ),
              ],
            ),
            actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: TextStyle(color: const Color(0xFF64748B), fontSize: 14.sp)),
              ),
              SizedBox(width: 8.w),
              ElevatedButton(
                onPressed: () {
                  final reason = controller.text.trim();
                  if (reason.isEmpty) return;
                  onStatusChange(BrandStatus.rejected, reason);
                  Navigator.pop(context);
                  onConfirm?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE11D48),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text("Reject Brand", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }
}
