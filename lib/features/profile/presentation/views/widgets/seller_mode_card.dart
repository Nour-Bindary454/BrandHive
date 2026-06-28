import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/sharedWidgets/basic_text.dart';

class SellerModeCard extends StatelessWidget {
  final VoidCallback onTap;

  const SellerModeCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicText(
                    text: 'switch_to_seller_mode'.tr(),
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                    isBold: true,
                  ),
                  SizedBox(height: 4.h),
                  BasicText(
                    text: 'manage_your_store_products_and_orders'.tr(),
                    fontSize: 12.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onPrimary.withOpacity(0.8),
                    isBold: false,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.storefront_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
