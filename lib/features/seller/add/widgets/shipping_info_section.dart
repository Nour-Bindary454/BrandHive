import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/add/widgets/add_product_text_field.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippingInfoSection extends StatefulWidget {
  const ShippingInfoSection({super.key});

  @override
  State<ShippingInfoSection> createState() => _ShippingInfoSectionState();
}

class _ShippingInfoSectionState extends State<ShippingInfoSection> {
  bool isFreeShipping = true;

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'shipping_information'.tr(),
            fontSize: 14,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AddProductTextField(
                  label: 'Weight (Kg) *',
                  hintText: '2_5'.tr(),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AddProductTextField(
                  label: 'Length (cm) *',
                  hintText: '100'.tr(),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AddProductTextField(
                  label: 'Width (cm) *',
                  hintText: '80'.tr(),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          GestureDetector(
            onTap: () {
              setState(() {
                isFreeShipping = !isFreeShipping;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Container(
                    width: 16.r,
                    height: 16.r,
                    decoration: BoxDecoration(
                      color: isFreeShipping ? const Color(0xFFFACC15) : Colors.white,
                      border: Border.all(color: isFreeShipping ? Colors.transparent : Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    child: isFreeShipping ? Icon(Icons.check, color: Colors.black, size: 12.sp) : const SizedBox(),
                  ),
                  SizedBox(width: 10.w),
                  BasicText(
                    text: 'free_shipping_available'.tr(),
                    fontSize: 11,
                    color: const Color(0xFF0F172A),
                    isBold: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
