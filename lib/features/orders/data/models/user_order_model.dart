import 'package:brand/features/checkout/data/models/order_item_model.dart';

class UserOrderModel {
  final String id;
  final String orderNumber;
  final String status;
  final double total;
  final DateTime createdAt;
  final List<OrderItemModel> items;
  final String paymentMethod;
  final String userEmail;

  UserOrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.items,
    required this.paymentMethod,
    required this.userEmail,
  });

  factory UserOrderModel.fromJson(Map<String, dynamic> json) {
    return UserOrderModel(
      id: json['_id'] ?? json['id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      status: json['status'] ?? 'pending',
      total: (json['total'] ?? 0).toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      items: (json['items'] as List?)
              ?.map((item) => OrderItemModel.fromJson(item))
              .toList() ??
          [],
      paymentMethod: json['paymentMethod'] ?? 'cash',
      userEmail: json['user'] is Map ? (json['user']['email'] ?? '') : '',
    );
  }
}
