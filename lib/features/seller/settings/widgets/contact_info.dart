import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:brand/features/seller/settings/widgets/settings_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mail_outline, color: const Color(0xFF4C79BD), size: 18.sp),
              SizedBox(width: 8.w),
              BasicText(
                text: 'contact_information'.tr().tr(),
                fontSize: 14,
                color: const Color(0xFF1F2937),
                isBold: true,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          const SettingsTextField(
            label: 'Email Address',
            initialValue: 'nile.weavers@example.com',
          ),
          SizedBox(height: 15.h),
          const SettingsTextField(
            label: 'Phone Number',
            initialValue: '+20 100 123 4567',
          ),
          SizedBox(height: 15.h),
          const SettingsTextField(
            label: 'Business Address',
            initialValue: '123 Khan El-Khalili St, Cairo',
          ),
        ],
      ),
    );
  }
}
