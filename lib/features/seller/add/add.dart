import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/add/widgets/add_product_actions.dart';
import 'package:brand/features/seller/add/widgets/pricing_stock_section.dart';
import 'package:brand/features/seller/add/widgets/product_details_section.dart';
import 'package:brand/features/seller/add/widgets/product_images_section.dart';
import 'package:brand/features/seller/add/widgets/seo_visibility_section.dart';
import 'package:brand/features/seller/add/widgets/shipping_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Internal App Bar Layout
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                children: [
                  BasicText(
                    text: 'add_new_product'.tr().tr(),
                    fontSize: 18,
                    color: const Color(0xFF0F172A),
                    isBold: true,
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100.h),
                children: const [
                  ProductImagesSection(),
                  ProductDetailsSection(),
                  PricingStockSection(),
                  ShippingInfoSection(),
                  SeoVisibilitySection(),
                  AddProductActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
