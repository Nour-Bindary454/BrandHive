import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/features/checkout/data/models/order_model.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
<<<<<<< HEAD
  final OrderModel order;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.order, required this.onTap});
=======
  final String orderId;
  final String date;
  final String status;
  final List<String> items;
  final String additionalItems;
  final String price;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.items,
    required this.additionalItems,
    required this.price,
    this.onTap,
  });
>>>>>>> b638b3040374aa6e62f93d89ede990324fbda31e

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

<<<<<<< HEAD
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
=======
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Order ID & Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: orderId,
                      fontSize: 15.sp,
                      color: const Color(0xFF1E293B),
                      isBold: true,
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 14.sp, color: const Color(0xFF64748B)),
                        SizedBox(width: 5.w),
                        BasicText(
                          text: date,
                          fontSize: 12.sp,
                          color: const Color(0xFF64748B),
                          isBold: false,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isDelivered ? const Color(0xFFBCE6A6) : const Color(0xFF93C5FD),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: BasicText(
                    text: status,
                    fontSize: 12.sp,
                    color: isDelivered ? const Color(0xFF166534) : const Color(0xFF1D4ED8),
                    isBold: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Items List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items.map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: BasicText(
                      text: item,
                      fontSize: 13.sp,
                      color: const Color(0xFF1E293B),
                      isBold: false,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                BasicText(
                  text: additionalItems,
                  fontSize: 11.sp,
                  color: const Color(0xFF94A3B8),
                  isBold: false,
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Footer: Price & Buttons
            Row(
              children: [
                BasicText(
                  text: price,
                  fontSize: 16.sp,
                  color: const Color(0xFF1E293B),
                  isBold: true,
                ),
                const Spacer(),
                const OrderOutlinedButton(text: "Invoice", icon: Icons.download_outlined),
                SizedBox(width: 10.w),
                const OrderFilledButton(text: "Track"),
>>>>>>> b638b3040374aa6e62f93d89ede990324fbda31e
              ],
            ),
          ],
        ),
      ),
    );
  }
}
