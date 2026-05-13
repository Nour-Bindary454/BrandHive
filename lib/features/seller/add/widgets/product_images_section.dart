import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImagesSection extends StatelessWidget {
  const ProductImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'product_images'.tr(),
            fontSize: 14,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 12.h),
          Container(
            height: 90.h,
            width: 90.w,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage(PngImages.addproduct),
                  color: Colors.grey.shade500,
                  size: 24.sp,
                ),
                SizedBox(height: 4.h),
                BasicText(
                  text: 'add_photo'.tr(),
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  isBold: false,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          BasicText(
            text: 'upload_up_to_5_photos_recommended_800x800px'.tr(),
            fontSize: 10,
            color: Colors.grey.shade500,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
