import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemsOrderedCard extends StatelessWidget {
  const ItemsOrderedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'items_ordered'.tr(),
            fontSize: 12,
            color: Colors.grey.shade600,
            isBold: true,
          ),
          SizedBox(height: 15.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            separatorBuilder: (context, index) => SizedBox(height: 15.h),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      index == 0
                          ? PngImages.fashion
                          : PngImages.homeDecor, // Dummy images
                      width: 50.r,
                      height: 50.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasicText(
                          text: index == 0
                              ? 'Leather Ankle Boot For Women'
                              : 'Leather Slipper For Women',
                          fontSize: 12,
                          color: const Color(
                            0xFF1B354D,
                          ), // Dark blue like buttonColorDark
                          isBold: true,
                        ),
                        SizedBox(height: 4.h),
                        BasicText(
                          text: 'qty_1'.tr(),
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          isBold: false,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
