import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:brand/features/seller/settings/widgets/settings_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreInfo extends StatelessWidget {
  const StoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'store_information'.tr(),
            fontSize: 14,
            color: const Color(0xFF1F2937),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          const SettingsTextField(
            label: 'Store Name',
            initialValue: 'Nile Weavers',
          ),
          SizedBox(height: 15.h),
          const SettingsTextField(
            label: 'Store Description',
            initialValue:
                'Preserving the art of Egyptian weaving\nthrough modern designs.',
            maxLines: 3,
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              const Expanded(
                child: SettingsTextField(label: 'City', initialValue: 'Cairo'),
              ),
              SizedBox(width: 15.w),
              const Expanded(
                child: SettingsTextField(
                  label: 'Country',
                  initialValue: 'Egypt',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
