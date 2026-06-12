class AdminSupportMessagesStats {
  final int open;
  final int inProgress;
  final int resolved;

  AdminSupportMessagesStats({
    required this.open,
    required this.inProgress,
    required this.resolved,
  });

  factory AdminSupportMessagesStats.fromJson(Map<String, dynamic> json) {
    return AdminSupportMessagesStats(
      open: json['open'] ?? 0,
      inProgress: json['inProgress'] ?? 0,
      resolved: json['resolved'] ?? 0,
    );
  }
}
