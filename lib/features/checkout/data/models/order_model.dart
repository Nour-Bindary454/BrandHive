import 'package:equatable/equatable.dart';
import 'address_model.dart';
import 'order_item_model.dart';
import 'status_history_model.dart';

class OrderModel extends Equatable {
  final String? id;
  final String? orderNumber;
  final dynamic user;
  final AddressModel shippingAddress;
  final String paymentMethod;
  final List<OrderItemModel> items;
  final double subtotal;
  final double shippingFee;
  final double tax;
  final double discount;
  final double total;
  final String? status;
  final String? paymentStatus;
  final String? paymentTransactionId;
  final List<StatusHistoryModel>? statusHistory;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrderModel({
    this.id,
    this.orderNumber,
    this.user,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.items,
    required this.subtotal,
    required this.shippingFee,
    this.tax = 0,
    this.discount = 0,
    required this.total,
    this.status,
    this.paymentStatus,
    this.paymentTransactionId,
    this.statusHistory,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      orderNumber: json['orderNumber'],
      user: json['user'] is Map ? json['user']['_id'] : json['user'],
      shippingAddress: AddressModel.fromJson(json['shippingAddress']),
      paymentMethod: json['paymentMethod'] ?? '',
      items: (json['items'] as List?)
              ?.map((item) => OrderItemModel.fromJson(item))
              .toList() ??
          [],
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      shippingFee: (json['shippingFee'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      paymentTransactionId: json['paymentTransactionId'],
      statusHistory: (json['statusHistory'] as List?)
          ?.map((e) => StatusHistoryModel.fromJson(e))
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shippingAddress': shippingAddress.toJson(),
      'paymentMethod': paymentMethod,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'shippingFee': shippingFee,
      'tax': tax,
      'discount': discount,
      'total': total,
      if (paymentTransactionId != null) 'paymentTransactionId': paymentTransactionId,
      if (statusHistory != null) 'statusHistory': statusHistory!.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id, orderNumber, user, shippingAddress, paymentMethod, items,
        subtotal, shippingFee, tax, discount, total, status, paymentStatus,
        paymentTransactionId, statusHistory, createdAt, updatedAt,
      ];
}
