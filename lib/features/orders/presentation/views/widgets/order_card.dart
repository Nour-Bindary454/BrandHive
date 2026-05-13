import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/features/checkout/data/models/order_model.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Determine status color
    Color statusColor = Colors.grey;
    final status = order.status?.toLowerCase() ?? 'pending';
    if (status == 'pending') statusColor = Colors.orange;
    if (status == 'confirmed') statusColor = Colors.blue;
    if (status == 'shipped') statusColor = Colors.purple;
    if (status == 'delivered') statusColor = Colors.green;
    if (status == 'canceled' || status == 'failed') statusColor = Colors.red;

    final dateStr = order.createdAt != null 
        ? DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt!) 
        : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BasicText(
                  text: 'Order #${order.orderNumber ?? order.id?.substring(0, 8) ?? 'N/A'}',
                  fontSize: 16.sp,
                  isBold: true,
                  color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: BasicText(
                    text: status.toUpperCase(),
                    fontSize: 10.sp,
                    isBold: true,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 14.sp, color: Colors.grey),
                SizedBox(width: 6.w),
                BasicText(
                  text: dateStr,
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                  isBold: false,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            const Divider(),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: 'total_amount'.tr(),
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                      isBold: false,
                    ),
                    SizedBox(height: 2.h),
                    BasicText(
                      text: 'EGP ${order.total.toStringAsFixed(2)}',
                      fontSize: 16.sp,
                      isBold: true,
                      color: BasicColors.buttonColorDark,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BasicText(
                      text: 'payment'.tr(),
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                      isBold: false,
                    ),
                    SizedBox(height: 2.h),
                    BasicText(
                      text: order.paymentMethod.toUpperCase(),
                      fontSize: 14.sp,
                      isBold: true,
                      color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
