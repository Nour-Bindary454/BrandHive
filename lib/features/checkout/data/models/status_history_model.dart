import 'package:equatable/equatable.dart';

class StatusHistoryModel extends Equatable {
  final String status;
  final DateTime timestamp;
  final String? note;

  const StatusHistoryModel({
    required this.status,
    required this.timestamp,
    this.note,
  });

  factory StatusHistoryModel.fromJson(Map<String, dynamic> json) {
    return StatusHistoryModel(
      status: json['status'] ?? '',
      timestamp: json['changedAt'] != null 
          ? DateTime.parse(json['changedAt']) 
          : (json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now()),
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
    };
  }

  @override
  List<Object?> get props => [status, timestamp, note];
}
