import 'package:brand/features/coupon/presentation/views/admin_coupons_view.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerCouponsSection extends StatelessWidget {
  const SellerCouponsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'promotions'.tr(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF94A3B8),
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SettingsCard(
          child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(
                  CupertinoIcons.tag_fill,
                  color: Color(0xFFEA580C),
                ),
              ),
              title: Text(
                'store_coupons'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              subtitle: Text(
                'seller_coupons_subtitle'.tr(),
                style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SellerCouponsView(),
                  ),
                );
              },
            ),
        ),
      ],
    );
  }
}
