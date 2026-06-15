import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/sharedWidgets/shared_order_details_view.dart';
import 'package:brand/features/orders/data/models/user_order_model.dart';
import 'package:brand/features/orders/presentation/views/widgets/order_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersListView extends StatelessWidget {
  final List<UserOrderModel> orders;

  const OrdersListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final itemsList = order.items.asMap().entries.map((entry) {
          return "${entry.key + 1}.${entry.value.productName}";
        }).toList();

        final dateStr = DateFormat('MMM dd, yyyy').format(order.createdAt);

        return OrderCard(
          orderId: order.orderNumber.isNotEmpty ? order.orderNumber : order.id,
          date: dateStr,
          status: order.status,
          items: itemsList,
          additionalItems: "+${order.items.length} items total",
          price: "${order.total.toStringAsFixed(0)} EGP",
          onTap: () {
            final detailsItems = order.items.map((item) => SharedOrderItemModel(
              productImage: item.productImage,
              productName: item.productName,
              quantity: item.quantity,
              unitPrice: item.unitPrice,
            )).toList();

            final email = order.userEmail.isNotEmpty
                ? order.userEmail
                : (CacheHelper.getData(key: 'email') ?? '');

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SharedOrderDetailsView(
                  orderNumber: order.orderNumber.isNotEmpty ? order.orderNumber : order.id,
                  status: order.status,
                  paymentMethod: order.paymentMethod,
                  createdAt: dateStr,
                  userEmail: email,
                  total: order.total,
                  items: detailsItems,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
