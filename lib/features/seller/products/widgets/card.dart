import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerProductCard extends StatelessWidget {
  const SellerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      padding: EdgeInsets.only(left: 9.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          // Image Section
          Container(
            width: 90.w,
            height: 90.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5), // Light grey background for image
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
              child: Image.asset(
                PngImages.fashion, // Replace with actual product image
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 15.w),

          // Details Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BasicText(
                    text: 'Split-Hem Flare Pants',
                    fontSize: 14,
                    color: BasicColors.buttonColorDark, // Dark blue text
                    isBold: true,
                  ),
                  SizedBox(height: 4.h),
                  BasicText(
                    text: 'CARENA',
                    fontSize: 11,
                    color: Colors.blueGrey.shade400, // Light grayish/blue text
                    isBold: true,
                  ),
                  const Spacer(),
                  BasicText(
                    text: '799 EGP',
                    fontSize: 16,
                    color: BasicColors
                        .buttonColorLight, // Core blue color for price
                    isBold: true,
                  ),
                ],
              ),
            ),
          ),

          // Delete Icon Section
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: GestureDetector(
              onTap: () {
                // Delete action
              },
              child: Image.asset(PngImages.trash),
            ),
          ),
        ],
      ),
    );
  }
}
