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
    // Determine status color and icon
    Color statusColor = Colors.orange;
    IconData statusIcon = Icons.pending_actions_rounded;
    final status = order.status?.toLowerCase() ?? 'pending';
    
    if (status == 'pending') {
      statusColor = Colors.orange;
      statusIcon = Icons.pending_actions_rounded;
    } else if (status == 'confirmed') {
      statusColor = Colors.blue;
      statusIcon = Icons.check_circle_outline_rounded;
    } else if (status == 'shipped') {
      statusColor = Colors.purple;
      statusIcon = Icons.local_shipping_outlined;
    } else if (status == 'delivered') {
      statusColor = Colors.green;
      statusIcon = Icons.task_alt_rounded;
    } else if (status == 'canceled' || status == 'failed') {
      statusColor = Colors.red;
      statusIcon = Icons.cancel_outlined;
    }

    final dateStr = order.createdAt != null 
        ? DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt!) 
        : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50.r,
                  height: 50.r,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: statusColor, size: 26.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${order.orderNumber ?? order.id?.substring(0, 8) ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Outfit',
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        dateStr,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            const Divider(),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${order.total.toStringAsFixed(0)} EGP',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        color: BasicColors.buttonColorLight,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Payment',
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      order.paymentMethod.toUpperCase(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey.shade400),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
