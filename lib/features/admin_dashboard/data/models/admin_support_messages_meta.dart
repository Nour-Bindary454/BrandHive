import 'admin_support_messages_stats.dart';

class AdminSupportMessagesMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final AdminSupportMessagesStats? stats;

  AdminSupportMessagesMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    this.stats,
  });

  factory AdminSupportMessagesMeta.fromJson(Map<String, dynamic> json) {
    return AdminSupportMessagesMeta(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
      stats: json['stats'] != null
          ? AdminSupportMessagesStats.fromJson(json['stats'])
          : null,
    );
  }
}
