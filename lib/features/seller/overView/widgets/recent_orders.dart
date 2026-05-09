import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/overView/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BasicText(
                text: 'recent_orders'.tr().tr(),
                fontSize: 16,
                color: const Color(0xFF0F172A),
                isBold: true,
              ),
              BasicText(
                text: 'view_all'.tr().tr(),
                fontSize: 12,
                color: const Color(0xFF5384DB),
                isBold: true,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          const OrderCard(
            name: 'Sarah Hassan',
            avatar: 'SH',
            orderNo: '2931',
            items: '2',
            price: '1,250',
          ),
          const OrderCard(
            name: 'salma nasser',
            avatar: 'SH',
            orderNo: '2932',
            items: '2',
            price: '7850',
          ),
          const OrderCard(
            name: 'hossam maged',
            avatar: 'SH',
            orderNo: '2933',
            items: '2',
            price: '1,550',
          ),
        ],
      ),
    );
  }
}
