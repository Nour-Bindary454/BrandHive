import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/orders/widgets/completed_action_buttons.dart';
import 'package:brand/features/seller/orders/widgets/order_status.dart';
import 'package:brand/features/seller/orders/widgets/order_status_pill.dart';
import 'package:brand/features/seller/orders/widgets/pending_action_buttons.dart';
import 'package:brand/features/seller/orders/widgets/processing_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManagementOrderCard extends StatelessWidget {
  final String orderId;
  final String timeAgo;
  final String customerName;
  final String itemsCount;
  final String price;
  final OrderStatus status;

  const ManagementOrderCard({
    super.key,
    required this.orderId,
    required this.timeAgo,
    required this.customerName,
    required this.itemsCount,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h, left: 20.w, right: 20.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BasicText(
                        text: orderId,
                        fontSize: 14,
                        color: const Color(0xFF0F172A),
                        isBold: true,
                      ),
                      BasicText(
                        text: '  •  $timeAgo',
                        fontSize: 10,
                        color: Colors.grey.shade500,
                        isBold: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  BasicText(
                    text: customerName,
                    fontSize: 13,
                    color: const Color(0xFF1F2937),
                    isBold: true,
                  ),
                ],
              ),
              OrderStatusPill(status: status),
            ],
          ),

          SizedBox(height: 15.h),
          Divider(color: Colors.grey.shade200, height: 1),
          SizedBox(height: 15.h),

          // Items and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.grey.shade400,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  BasicText(
                    text: '$itemsCount Items',
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    isBold: false,
                  ),
                ],
              ),
              BasicText(
                text: '$price EGP',
                fontSize: 14,
                color: const Color(0xFF0F172A),
                isBold: true,
              ),
            ],
          ),

          // Action Buttons
          if (status != OrderStatus.canceled) ...[
            SizedBox(height: 15.h),
            _buildActionButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    switch (status) {
      case OrderStatus.pending:
        return const PendingActionButtons();
      case OrderStatus.processing:
        return const ProcessingActionButtons();
      case OrderStatus.completed:
        return const CompletedActionButtons();
      case OrderStatus.canceled:
        return const SizedBox.shrink();
    }
  }
}
