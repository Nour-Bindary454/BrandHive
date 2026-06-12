import 'support_response_data.dart';

class SupportResponseModel {
  final String message;
  final SupportResponseData? data;

  SupportResponseModel({
    required this.message,
    this.data,
  });

  factory SupportResponseModel.fromJson(Map<String, dynamic> json) {
    return SupportResponseModel(
      message: json['message'] ?? '',
      data: json['data'] != null ? SupportResponseData.fromJson(json['data']) : null,
    );
  }
}
