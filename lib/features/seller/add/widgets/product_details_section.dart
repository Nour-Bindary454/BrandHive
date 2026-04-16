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
            text: 'Product Details',
            fontSize: 14,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          const AddProductTextField(
            label: 'Product Name *',
            hintText: 'e.g., Handwoven Kilim Rug',
          ),
          SizedBox(height: 12.h),
          const AddProductTextField(
            label: 'Description *',
            hintText: 'Describe your product in detail . mention material, dimension, care instruction, etc ..',
            maxLines: 4,
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AddProductTextField(
                  label: 'Category *',
                  hintText: 'Fashion',
                  suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                ),
              ),
              SizedBox(width: 10.w),
              const Expanded(
                child: AddProductTextField(
                  label: 'SKU (Optional)',
                  hintText: 'e.g., KLM-001',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
