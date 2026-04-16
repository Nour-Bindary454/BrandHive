import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DangerZone extends StatelessWidget {
  const DangerZone({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      borderColor: Colors.red.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'Danger Zone',
            fontSize: 14,
            color: const Color(0xFF1F2937),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.red.shade200),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade400,
                      size: 16.sp,
                    ),
                    SizedBox(width: 8.w),
                    BasicText(
                      text: 'Deactivate Store',
                      fontSize: 11,
                      color: Colors.red.shade400,
                      isBold: true,
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.red.shade400,
                  size: 16.sp,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          BasicText(
            text:
                'Deactivating your store will hide all products from customers but keep your data intact.',
            fontSize: 10,
            color: Colors.grey.shade500,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
