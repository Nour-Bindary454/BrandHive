import 'package:brand/features/notifications/data/repository/notifications_repo.dart';
import 'package:brand/features/notifications/presentation/viewmodel/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository repo;

  NotificationsCubit(this.repo) : super(NotificationsState());

  /// Fetch notifications (with caching - skip if already loaded)
  Future<void> fetchNotifications({bool forceRefresh = false}) async {
    if (!forceRefresh && state.notifications.isNotEmpty) return;

    emit(state.copyWith(isLoading: true, error: null));

    final result = await repo.getNotifications();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.errMessage));
      },
      (notifications) {
        final unread = notifications.where((n) => !n.isRead).length;
        emit(state.copyWith(
          isLoading: false,
          notifications: notifications,
          unreadCount: unread,
        ));
      },
    );
  }

  /// Fetch unread count only (lightweight)
  Future<void> fetchUnreadCount() async {
    final result = await repo.getUnreadCount();
    result.fold(
      (_) {},
      (count) {
        emit(state.copyWith(unreadCount: count));
      },
    );
  }

  /// Mark all notifications as read (optimistic)
  Future<void> markAllAsRead() async {
    // Optimistic update
    final updatedNotifications =
        state.notifications.map((n) => n.copyWith(isRead: true)).toList();
    emit(state.copyWith(notifications: updatedNotifications, unreadCount: 0));

    // API call
    final result = await repo.markAllAsRead();
    result.fold(
      (failure) {
        // Revert on failure
        fetchNotifications(forceRefresh: true);
      },
      (_) {},
    );
  }

  /// Mark single notification as read (optimistic)
  Future<void> markAsRead(String id) async {
    // Optimistic update
    final updatedNotifications = state.notifications.map((n) {
      if (n.id == id) return n.copyWith(isRead: true);
      return n;
    }).toList();
    final newUnread = updatedNotifications.where((n) => !n.isRead).length;
    emit(state.copyWith(
      notifications: updatedNotifications,
      unreadCount: newUnread,
    ));

    // API call
    final result = await repo.markAsRead(id);
    result.fold(
      (failure) {
        fetchNotifications(forceRefresh: true);
      },
      (_) {},
    );
  }

  /// Delete notification (optimistic)
  Future<void> deleteNotification(String id) async {
    // Save for potential revert
    final previousNotifications = state.notifications;
    final previousUnread = state.unreadCount;

    // Optimistic update
    final wasUnread = state.notifications.any((n) => n.id == id && !n.isRead);
    final updatedNotifications =
        state.notifications.where((n) => n.id != id).toList();
    emit(state.copyWith(
      notifications: updatedNotifications,
      unreadCount: wasUnread ? state.unreadCount - 1 : state.unreadCount,
    ));

    // API call
    final result = await repo.deleteNotification(id);
    result.fold(
      (failure) {
        // Revert on failure
        emit(state.copyWith(
          notifications: previousNotifications,
          unreadCount: previousUnread,
        ));
      },
      (_) {},
    );
  }
}
