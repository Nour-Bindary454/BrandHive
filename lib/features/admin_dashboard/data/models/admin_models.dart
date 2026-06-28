import 'package:flutter/material.dart';

class AdminStatModel {
  final String value;
  final String label;
  final String subtitle;
  final IconData icon;
  final Color color;

  AdminStatModel({
    required this.value,
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

enum BrandStatus { pending, approved, rejected }

class AdminBrandRequest {
  final String id;
  final String name;
  final String location;
  final String category;
  final String date;
  final BrandStatus status;
  final bool shipsInternationally;
  final String? rejectionReason;
  final Map<String, dynamic> rawData; // Full payload from notification/API

  AdminBrandRequest({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.date,
    required this.status,
    this.shipsInternationally = false,
    this.rejectionReason,
    this.rawData = const {},
  });

  AdminBrandRequest copyWith({
    BrandStatus? status,
    String? rejectionReason,
    bool? shipsInternationally,
    String? category,
  }) {
    return AdminBrandRequest(
      id: id,
      name: name,
      location: location,
      category: category ?? this.category,
      date: date,
      status: status ?? this.status,
      shipsInternationally: shipsInternationally ?? this.shipsInternationally,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      rawData: rawData,
    );
  }
}

class AdminOrderModel {
  final String id;
  final String orderNumber;
  final String userEmail;
  final String status;
  final double total;
  final String createdAt;
  final String paymentMethod;
  final List<AdminOrderItem> items;

  AdminOrderModel({
    required this.id,
    required this.orderNumber,
    required this.userEmail,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.paymentMethod,
    required this.items,
  });

  factory AdminOrderModel.fromJson(Map<String, dynamic> json) {
    return AdminOrderModel(
      id: json['_id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      userEmail: json['user']?['email'] ?? '',
      status: json['status'] ?? '',
      total: double.tryParse(json['total'].toString()) ?? 0.0,
      createdAt: json['createdAt'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      items: (json['items'] as List?)
              ?.map((item) => AdminOrderItem.fromJson(item))
              .toList() ??
          [],
    );
  }

  AdminOrderModel copyWith({
    String? id,
    String? orderNumber,
    String? userEmail,
    String? status,
    double? total,
    String? createdAt,
    String? paymentMethod,
    List<AdminOrderItem>? items,
  }) {
    return AdminOrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      userEmail: userEmail ?? this.userEmail,
      status: status ?? this.status,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      items: items ?? this.items,
    );
  }
}

class AdminOrderItem {
  final String productName;
  final String productImage;
  final int quantity;
  final double unitPrice;

  AdminOrderItem({
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.unitPrice,
  });

  factory AdminOrderItem.fromJson(Map<String, dynamic> json) {
    return AdminOrderItem(
      productName: json['productName'] ?? '',
      productImage: json['productImage'] ?? '',
      quantity: json['quantity'] ?? 0,
      unitPrice: double.tryParse(json['unitPrice'].toString()) ?? 0.0,
    );
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type;
  final Map<String, dynamic> data;
  final bool isRead;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.data,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? '',
      data: json['data'] ?? {},
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] ?? '',
    );
  }
}

