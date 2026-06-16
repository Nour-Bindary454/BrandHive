import 'package:brand/features/coupon/data/models/coupon_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponCard extends StatelessWidget {
  final CouponModel coupon;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggle;
  final bool showActions;

  const CouponCard({
    super.key,
    required this.coupon,
    this.onEdit,
    this.onDelete,
    this.onToggle,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final expiryText = coupon.expiresAt != null
        ? '${coupon.expiresAt!.day}/${coupon.expiresAt!.month}/${coupon.expiresAt!.year}'
        : '—';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: coupon.isActive
              ? const Color(0xFF2D4373).withOpacity(0.15)
              : Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: coupon.isActive
                    ? [const Color(0xFF2D4373), const Color(0xFF4A78B8)]
                    : [Colors.grey.shade500, Colors.grey.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.local_offer, color: Colors.white, size: 22.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    coupon.code,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    coupon.discountLabel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (coupon.description != null &&
                    coupon.description!.isNotEmpty) ...[
                  Text(
                    coupon.description!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
                _infoRow(
                  Icons.calendar_today_outlined,
                  'coupon_expires'.tr(),
                  expiryText,
                ),
                SizedBox(height: 6.h),
                _infoRow(
                  Icons.shopping_bag_outlined,
                  'coupon_min_order'.tr(),
                  '${coupon.minOrderAmount.toStringAsFixed(0)} EGP',
                ),
                SizedBox(height: 6.h),
                _infoRow(
                  Icons.people_outline,
                  'coupon_usage'.tr(),
                  '${coupon.totalUsedCount}${coupon.totalUsageLimit != null ? ' / ${coupon.totalUsageLimit}' : ''}',
                ),
                if (showActions) ...[
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onToggle,
                          icon: Icon(
                            coupon.isActive
                                ? Icons.pause_circle_outline
                                : Icons.play_circle_outline,
                            size: 18.sp,
                          ),
                          label: Text(
                            coupon.isActive
                                ? 'deactivate'.tr()
                                : 'activate'.tr(),
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF2D4373),
                            side: const BorderSide(color: Color(0xFF2D4373)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      IconButton(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit_outlined),
                        color: const Color(0xFF4A78B8),
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete_outline),
                        color: const Color(0xFFEF4444),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: const Color(0xFF94A3B8)),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF94A3B8)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
      ],
    );
  }
}
