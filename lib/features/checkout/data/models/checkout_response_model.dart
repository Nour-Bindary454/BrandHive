import 'order_model.dart';

class CheckoutResponseModel {
  final String message;
  final OrderModel data;
  final String? paymentUrl;

  CheckoutResponseModel({
    required this.message,
    required this.data,
    this.paymentUrl,
  });

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseModel(
      message: json['message'] ?? '',
      data: OrderModel.fromJson(json['data']),
      paymentUrl: json['paymentUrl'],
    );
  }
}
