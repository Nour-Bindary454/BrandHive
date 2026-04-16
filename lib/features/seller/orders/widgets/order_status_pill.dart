import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/orders/widgets/order_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatusPill extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case OrderStatus.pending:
        bgColor = const Color(0xFFFFEDA6);
        textColor = const Color(0xFFD97706);
        text = 'PENDING';
        break;
      case OrderStatus.processing:
        bgColor = const Color(0xFFBFDBFE);
        textColor = const Color(0xFF2563EB);
        text = 'PROCESSING';
        break;
      case OrderStatus.completed:
        bgColor = const Color(0xFFBBF7D0);
        textColor = const Color(0xFF16A34A);
        text = 'COMPLETED';
        break;
      case OrderStatus.canceled:
        bgColor = const Color(0xFFFECACA);
        textColor = const Color(0xFFEF4444);
        text = 'CANCELED';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: BasicText(
        text: text,
        fontSize: 9,
        color: textColor,
        isBold: true,
      ),
    );
  }
}
