import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/notifications/data/models/notification_model.dart';
import 'package:brand/features/notifications/data/repository/notifications_repo.dart';
import 'package:dartz/dartz.dart';

class NotificationsRepoImpl implements NotificationsRepository {
  final ApiService apiService;

  NotificationsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final response =
          await apiService.getData(endPoint: EndPoints.notifications);
      final List<dynamic> data = response.data['data'] ?? [];
      final notifications =
          data.map((n) => NotificationModel.fromJson(n)).toList();
      return right(notifications);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final response = await apiService.getData(
          endPoint: EndPoints.notificationsUnreadCount);
      final count = response.data['data']?['count'] ?? 0;
      return right(count);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      await apiService.patchData(endPoint: EndPoints.notificationsReadAll);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String id) async {
    try {
      await apiService.patchData(
          endPoint: '${EndPoints.notifications}/$id/read');
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(String id) async {
    try {
      await apiService.deleteData(
          endPoint: '${EndPoints.notifications}/$id');
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
