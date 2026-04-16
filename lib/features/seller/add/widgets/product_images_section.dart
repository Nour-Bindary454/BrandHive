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
            text: 'Product Images',
            fontSize: 14,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 12.h),
          Container(
            height: 90.h,
            width: 90.w,
            decoration: BoxDecoration(
              color: Colors.white,
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
                  text: 'Add Photo',
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  isBold: false,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          BasicText(
            text: 'Upload up to 5 photos (recommended: 800x800px)',
            fontSize: 10,
            color: Colors.grey.shade500,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
