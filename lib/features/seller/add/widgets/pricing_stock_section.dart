import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/add/widgets/add_product_text_field.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PricingStockSection extends StatelessWidget {
  const PricingStockSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'Pricing & Stock',
            fontSize: 14,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: AddProductTextField(
                  label: 'Price (EGP) *',
                  hintText: '1200',
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AddProductTextField(
                  label: 'Stock Quantity *',
                  hintText: '6',
                  keyboardType: TextInputType.number,
                  suffixIcon: Icon(Icons.unfold_more, color: Colors.grey.shade400, size: 18.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          AddProductTextField(
            label: 'Cost Price (EGP) (Optional)',
            hintText: '800',
            keyboardType: TextInputType.number,
            suffixIcon: Icon(Icons.unfold_more, color: Colors.grey.shade400, size: 18.sp),
          ),
        ],
      ),
    );
  }
}
