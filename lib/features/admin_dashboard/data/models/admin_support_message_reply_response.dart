import 'admin_support_message_model.dart';

class AdminSupportMessageReplyResponse {
  final String message;
  final AdminSupportMessageModel? data;

  AdminSupportMessageReplyResponse({required this.message, this.data});

  factory AdminSupportMessageReplyResponse.fromJson(Map<String, dynamic> json) {
    return AdminSupportMessageReplyResponse(
      message: json['message'] ?? '',
      data: json['data'] != null
          ? AdminSupportMessageModel.fromJson(json['data'])
          : null,
    );
  }
}
