import 'package:brand/features/notifications/data/models/notification_model.dart';

class NotificationsState {
  final bool isLoading;
  final String? error;
  final List<NotificationModel> notifications;
  final int unreadCount;

  NotificationsState({
    this.isLoading = false,
    this.error,
    this.notifications = const [],
    this.unreadCount = 0,
  });

  NotificationsState copyWith({
    bool? isLoading,
    String? error,
    List<NotificationModel>? notifications,
    int? unreadCount,
  }) {
    return NotificationsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
