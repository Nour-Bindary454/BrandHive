class PaymobResponseModel {
  final PaymobTransactionData obj;

  PaymobResponseModel({required this.obj});

  factory PaymobResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymobResponseModel(
      obj: PaymobTransactionData.fromJson(json['obj']),
    );
  }
}

class PaymobTransactionData {
  final PaymobOrder order;
  final bool success;
  final int amountCents;

  PaymobTransactionData({
    required this.order,
    required this.success,
    required this.amountCents,
  });

  factory PaymobTransactionData.fromJson(Map<String, dynamic> json) {
    return PaymobTransactionData(
      order: PaymobOrder.fromJson(json['order']),
      success: json['success'] ?? false,
      amountCents: json['amount_cents'] ?? 0,
    );
  }
}

class PaymobOrder {
  final String id;

  PaymobOrder({required this.id});

  factory PaymobOrder.fromJson(Map<String, dynamic> json) {
    return PaymobOrder(
      id: json['id']?.toString() ?? '',
    );
  }
}
