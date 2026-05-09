import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LegalPolicies extends StatelessWidget {
  const LegalPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description_outlined, color: const Color(0xFF4C79BD), size: 18.sp),
              SizedBox(width: 8.w),
              BasicText(
                text: 'legal_policies'.tr().tr(),
                fontSize: 14,
                color: const Color(0xFF1F2937),
                isBold: true,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          _buildItem(context, 'Terms & Conditions'),
          _buildItem(context, 'Privacy Policy'),
          _buildItem(context, 'Return Policy', isLast: true),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, {bool isLast = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BasicText(
            text: title,
            fontSize: 11,
            color: const Color(0xFF1F2937),
            isBold: true,
          ),
          Icon(Icons.arrow_forward, color: Colors.grey.shade600, size: 16.sp),
        ],
      ),
    );
  }
}
