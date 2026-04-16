import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, color: const Color(0xFF4C79BD), size: 18.sp),
              SizedBox(width: 8.w),
              BasicText(
                text: 'Security',
                fontSize: 14,
                color: const Color(0xFF1F2937),
                isBold: true,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.lock_outline, color: const Color(0xFF1F2937), size: 16.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: BasicText(
                    text: 'Change Password',
                    fontSize: 11,
                    color: const Color(0xFF1F2937),
                    isBold: true,
                  ),
                ),
                Icon(Icons.arrow_forward, color: Colors.grey.shade600, size: 16.sp),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE), // Light blue background
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicText(
                  text: 'Two-Factor Authentication',
                  fontSize: 11,
                  color: const Color(0xFF1F2937),
                  isBold: true,
                ),
                SizedBox(height: 6.h),
                BasicText(
                  text: 'Add an extra layer of security to your account',
                  fontSize: 10,
                  color: const Color(0xFF1F2937).withOpacity(0.7),
                  isBold: false,
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(color: const Color(0xFF4C79BD).withOpacity(0.3)),
                  ),
                  child: BasicText(
                    text: 'Enable 2FA',
                    fontSize: 11,
                    color: const Color(0xFF4C79BD), // Blue action text
                    isBold: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
