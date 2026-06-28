import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/add/widgets/add_product_text_field.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'product_details'.tr(),
            fontSize: 14,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          AddProductTextField(
            label: 'Product Name *',
            hintText: 'e_g_handwoven_kilim_rug'.tr(),
          ),
          SizedBox(height: 12.h),
          AddProductTextField(
            label: 'Description *',
            hintText: 'describe_your_product_in_detail_mention_material_dimension_care_instruction_etc'.tr(),
            maxLines: 4,
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AddProductTextField(
                  label: 'Category *',
                  hintText: 'fashion'.tr(),
                  suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AddProductTextField(
                  label: 'SKU (Optional)',
                  hintText: 'e_g_klm_001'.tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
