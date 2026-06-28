import 'cart_item_model.dart';

class CartResponseModel {
  final String message;
  final CartDataModel data;

  CartResponseModel({required this.message, required this.data});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      message: json['message'] ?? '',
      data: CartDataModel.fromJson(json['data'] ?? {}),
    );
  }
}

class CartDataModel {
  final String id;
  final List<CartItemModel> items;
  final double subtotal;
  final double couponSaving;
  final double total;
  final int totalItems;
  final int totalQuantity;
  final bool hasPriceChanges;
  final List<dynamic> warnings;

  CartDataModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.couponSaving,
    required this.total,
    required this.totalItems,
    required this.totalQuantity,
    required this.hasPriceChanges,
    required this.warnings,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json['id'] ?? '',
      items:
          (json['items'] as List?)
              ?.map((e) => CartItemModel.fromJson(e))
              .toList() ??
          [],
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      couponSaving: (json['couponSaving'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      totalItems: json['totalItems'] ?? 0,
      totalQuantity: json['totalQuantity'] ?? 0,
      hasPriceChanges: json['hasPriceChanges'] ?? false,
      warnings: json['warnings'] ?? [],
    );
  }
}
