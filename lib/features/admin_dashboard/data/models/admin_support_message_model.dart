import 'admin_support_message_reply_by.dart';

class AdminSupportMessageModel {
  final String id;
  final String fullName;
  final String email;
  final String message;
  final String status;
  final String? adminReply;
  final String? repliedAt;
  final AdminSupportMessageReplyBy? repliedBy;
  final String createdAt;
  final String updatedAt;
  final String? userId;

  AdminSupportMessageModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.message,
    required this.status,
    this.adminReply,
    this.repliedAt,
    this.repliedBy,
    required this.createdAt,
    required this.updatedAt,
    this.userId,
  });

  factory AdminSupportMessageModel.fromJson(Map<String, dynamic> json) {
    String? parsedUserId;
    if (json['user'] != null) {
      if (json['user'] is String) {
        parsedUserId = json['user'];
      } else if (json['user'] is Map) {
        parsedUserId = json['user']['_id'] ?? json['user']['id'];
      }
    }

    AdminSupportMessageReplyBy? parsedRepliedBy;
    if (json['repliedBy'] != null) {
      if (json['repliedBy'] is String) {
        parsedRepliedBy = AdminSupportMessageReplyBy(id: json['repliedBy'], email: '');
      } else if (json['repliedBy'] is Map) {
        parsedRepliedBy = AdminSupportMessageReplyBy.fromJson(Map<String, dynamic>.from(json['repliedBy']));
      }
    }

    return AdminSupportMessageModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? 'open',
      adminReply: json['adminReply'],
      repliedAt: json['repliedAt'],
      repliedBy: parsedRepliedBy,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      userId: parsedUserId,
    );
  }
}
