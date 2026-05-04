import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/orders/presentation/views/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                const CustomBackarrow(),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: "My Orders",
                      fontSize: 20.sp,
                      color: const Color(0xFF1E293B),
                      isBold: true,
                    ),
                    BasicText(
                      text: "3 orders",
                      fontSize: 13.sp,
                      color: const Color(0xFF64748B),
                      isBold: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Divider
          const Divider(color: Color(0xFFF1F5F9), thickness: 1, height: 1),

          // List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: const [
                OrderCard(
                  orderId: "ORD-001",
                  date: "Dec 10, 2024",
                  status: "Delivered",
                  items: [
                    "1.Linen Resort Shirt",
                    "2.Cotton Scarf",
                    "3.Silver Ankh Necklace",
                  ],
                  additionalItems: "+3items total",
                  price: "3450 EGP",
                ),
                OrderCard(
                  orderId: "ORD-002",
                  date: "Dec 8, 2024",
                  status: "In Transit",
                  items: ["1.Leather Tote Bag"],
                  additionalItems: "+3items total",
                  price: "1800 EGP",
                ),
                OrderCard(
                  orderId: "ORD-003",
                  date: "Dec 1, 2024",
                  status: "Delivered",
                  items: ["1.Handwoven Kilim Rug", "2.Ceramic Serving Bowl"],
                  additionalItems: "+2items total",
                  price: "2080 EGP",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
