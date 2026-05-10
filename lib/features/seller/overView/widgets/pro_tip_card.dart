import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProTipCard extends StatelessWidget {
  const ProTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'pro_tip'.tr(),
            fontSize: 13,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 8.h),
          BasicText(
            text: 'adding_high_quality_photos_increases_sales_by_40_nupdate_your_product_gallery_today'.tr(),
            fontSize: 11,
            color: Colors.grey.shade600,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
