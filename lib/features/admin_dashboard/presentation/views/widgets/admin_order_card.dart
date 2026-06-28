import 'package:brand/core/sharedWidgets/shared_order_card.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/presentation/views/admin_order_details_view.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrderCard extends StatelessWidget {
  final AdminOrderModel order;
  const AdminOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final bool isDelivered = order.status.toLowerCase() == "delivered";
    final createdAt = DateTime.tryParse(order.createdAt);
    final dateStr = createdAt != null
        ? DateFormat('MMM dd, yyyy').format(createdAt)
        : order.createdAt;

    String firstItemImage = '';
    String firstItemName = 'Unknown Item';
    if (order.items.isNotEmpty) {
      firstItemImage = order.items.first.productImage;
      firstItemName = order.items.first.productName;
    }

    return SharedOrderCard(
      orderNumber: order.orderNumber,
      dateStr: dateStr,
      statusText: order.status.toUpperCase(),
      isDelivered: isDelivered,
      statusColor: _getStatusColor(order.status),
      userEmail: order.userEmail,
      firstItemImage: firstItemImage,
      firstItemName: firstItemName,
      additionalItemsCount: order.items.length > 1 ? order.items.length - 1 : 0,
      totalPriceText: "${order.total.toStringAsFixed(0)} EGP",
      onDetailsTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (innerContext) => BlocProvider.value(
              value: BlocProvider.of<AdminCubit>(context),
              child: AdminOrderDetailsView(order: order),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

