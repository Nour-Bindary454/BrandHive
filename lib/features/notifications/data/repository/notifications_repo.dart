import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/notifications/data/models/notification_model.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
  Future<Either<Failure, int>> getUnreadCount();
  Future<Either<Failure, void>> markAllAsRead();
  Future<Either<Failure, void>> markAsRead(String id);
  Future<Either<Failure, void>> deleteNotification(String id);
}
