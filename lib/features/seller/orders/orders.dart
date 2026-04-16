import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/orders/widgets/management_order_card.dart';
import 'package:brand/features/seller/orders/widgets/order_status.dart';
import 'package:brand/features/seller/orders/widgets/orders_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: BasicText(
                text: 'Orders Management',
                fontSize: 18,
                color: const Color(0xFF0F172A),
                isBold: true,
              ),
            ),
            SizedBox(height: 15.h),
            const OrdersFilter(),
            SizedBox(height: 5.h),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 15.h, bottom: 100.h),
                children: const [
                  ManagementOrderCard(
                    orderId: 'ORD-9283',
                    timeAgo: '2 mins ago',
                    customerName: 'Sarah Hassan',
                    itemsCount: '2',
                    price: '1250',
                    status: OrderStatus.pending,
                  ),
                  ManagementOrderCard(
                    orderId: 'ORD-9282',
                    timeAgo: '1 hour ago',
                    customerName: 'Ahmed Ali',
                    itemsCount: '2',
                    price: '3000',
                    status: OrderStatus.processing,
                  ),
                  ManagementOrderCard(
                    orderId: 'ORD-9282',
                    timeAgo: 'Yesterday',
                    customerName: 'Mona Magdy',
                    itemsCount: '3',
                    price: '2200',
                    status: OrderStatus.completed,
                  ),
                  ManagementOrderCard(
                    orderId: 'ORD-9282',
                    timeAgo: '2 days ago',
                    customerName: 'Karem Tarek',
                    itemsCount: '1',
                    price: '800',
                    status: OrderStatus.canceled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
