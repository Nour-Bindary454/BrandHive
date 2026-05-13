import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCard extends StatelessWidget {
  final String name;
  final String avatar;
  final String orderNo;
  final String items;
  final String price;

  const OrderCard({
    super.key,
    required this.name,
    required this.avatar,
    required this.orderNo,
    required this.items,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: const BoxDecoration(
              color: Color(0xFFEAEFF5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: BasicText(
                text: avatar,
                fontSize: 12,
                color: Colors.grey.shade600,
                isBold: true,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicText(
                  text: name,
                  fontSize: 13,
                  color: const Color(0xFF0F172A),
                  isBold: true,
                ),
                SizedBox(height: 4.h),
                BasicText(
                  text: 'Order #$orderNo • $items items',
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  isBold: false,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BasicText(
                text: '$price EGP',
                fontSize: 12,
                color: const Color(0xFF0F172A),
                isBold: true,
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E5), // Light yellow bg
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: BasicText(
                  text: 'pending'.tr(),
                  fontSize: 10,
                  color: const Color(0xFFF5A623), // Deep yellow text
                  isBold: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
