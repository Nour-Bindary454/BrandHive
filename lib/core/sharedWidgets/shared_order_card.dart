import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/orders/presentation/views/widgets/order_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedOrderCard extends StatelessWidget {
  final String orderNumber;
  final String dateStr;
  final String statusText;
  final bool isDelivered;
  final Color statusColor;
  final String userEmail;
  final String firstItemImage;
  final String firstItemName;
  final int additionalItemsCount;
  final String totalPriceText;
  final VoidCallback onDetailsTap;

  const SharedOrderCard({
    super.key,
    required this.orderNumber,
    required this.dateStr,
    required this.statusText,
    required this.isDelivered,
    required this.statusColor,
    required this.userEmail,
    required this.firstItemImage,
    required this.firstItemName,
    required this.additionalItemsCount,
    required this.totalPriceText,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Order ID & Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: orderNumber,
                      fontSize: 14.sp,
                      color: const Color(0xFF1E293B),
                      isBold: true,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12.sp,
                          color: const Color(0xFF64748B),
                        ),
                        SizedBox(width: 4.w),
                        BasicText(
                          text: dateStr,
                          fontSize: 11.sp,
                          color: const Color(0xFF64748B),
                          isBold: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isDelivered
                      ? const Color(0xFFBCE6A6)
                      : statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: BasicText(
                  text: statusText,
                  fontSize: 10.sp,
                  color: isDelivered ? const Color(0xFF166534) : statusColor,
                  isBold: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // User Info
          Row(
            children: [
              Icon(Icons.person_outline, size: 12.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Expanded(
                child: BasicText(
                  text: userEmail,
                  fontSize: 11.sp,
                  color: Colors.grey,
                  isBold: false,
                ),
              ),
            ],
          ),
          const Divider(height: 20),

          // Items List (Simplified)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.network(
                      firstItemImage,
                      width: 25.w,
                      height: 25.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 25.w,
                        height: 25.h,
                        color: Colors.grey[100],
                        child: Icon(
                          Icons.image,
                          size: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: BasicText(
                      text: firstItemName,
                      fontSize: 12.sp,
                      color: const Color(0xFF1E293B),
                      isBold: false,
                    ),
                  ),
                ],
              ),
              if (additionalItemsCount > 0)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: BasicText(
                    text: "+$additionalItemsCount more items",
                    fontSize: 10.sp,
                    color: const Color(0xFF94A3B8),
                    isBold: false,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Footer: Price & Buttons
          Row(
            children: [
              BasicText(
                text: totalPriceText,
                fontSize: 14.sp,
                color: const Color(0xFF1E293B),
                isBold: true,
              ),
              const Spacer(),
              OrderOutlinedButton(
                text: "Details",
                icon: Icons.info_outline,
                onTap: onDetailsTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
