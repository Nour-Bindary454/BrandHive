import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/sharedWidgets/basic_colors.dart';
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
          color: BasicColors.buttonColorDark,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: BasicColors.buttonColorDark.withOpacity(0.3),
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
                    text: 'Switch to Seller Mode',
                    fontSize: 16.sp,
                    color: BasicColors.white,
                    isBold: true,
                  ),
                  SizedBox(height: 4.h),
                  BasicText(
                    text: 'Manage your store, products, and orders',
                    fontSize: 12.sp,
                    color: BasicColors.white.withOpacity(0.8),
                    isBold: false,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: BasicColors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.storefront_outlined,
                color: BasicColors.white,
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
