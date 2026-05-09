import 'package:easy_localization/easy_localization.dart';
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
            text: 'danger_zone'.tr().tr(),
            fontSize: 14,
            color: const Color(0xFF1F2937),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
                      text: 'deactivate_store'.tr().tr(),
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
            text: 'deactivating_your_store_will_hide_all_products_from_customers_but_keep_your_data_intact'.tr().tr(),
            fontSize: 10,
            color: Colors.grey.shade500,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
