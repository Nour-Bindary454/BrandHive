import 'package:brand/core/sharedWidgets/shared_order_details_view.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AdminOrderDetailsView extends StatelessWidget {
  final AdminOrderModel order;
  const AdminOrderDetailsView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.tryParse(order.createdAt);
    final dateStr = createdAt != null
        ? DateFormat('MMM dd, yyyy - hh:mm a').format(createdAt)
        : order.createdAt;

    final items = order.items
        .map((e) => SharedOrderItemModel(
              productImage: e.productImage,
              productName: e.productName,
              quantity: e.quantity,
              unitPrice: e.unitPrice,
            ))
        .toList();

    return SharedOrderDetailsView(
      orderNumber: order.orderNumber,
      status: order.status,
      paymentMethod: order.paymentMethod,
      createdAt: dateStr,
      userEmail: order.userEmail,
      total: order.total,
      items: items,
    );
  }
}

