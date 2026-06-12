import 'admin_support_message_model.dart';
import 'admin_support_messages_meta.dart';

class AdminSupportMessagesResponse {
  final List<AdminSupportMessageModel> data;
  final AdminSupportMessagesMeta? meta;

  AdminSupportMessagesResponse({required this.data, this.meta});

  factory AdminSupportMessagesResponse.fromJson(Map<String, dynamic> json) {
    return AdminSupportMessagesResponse(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => AdminSupportMessageModel.fromJson(e))
              .toList()
          : [],
      meta: json['meta'] != null
          ? AdminSupportMessagesMeta.fromJson(json['meta'])
          : null,
    );
  }
}
