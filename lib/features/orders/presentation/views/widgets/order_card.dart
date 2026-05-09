import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/features/orders/presentation/views/widgets/order_outlined_button.dart';
import 'package:brand/features/orders/presentation/views/widgets/order_filled_button.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final List<String> items;
  final String additionalItems;
  final String price;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.items,
    required this.additionalItems,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDelivered = status.toLowerCase() == "delivered";

    return Container(
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
            ],
          ),
        ],
      ),
    );
  }
}
