import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminSuccess extends AdminState {
  final List<AdminStatModel> stats;
  final List<AdminBrandRequest> requests;
  final List<NotificationModel>? notifications;

  AdminSuccess({
    required this.stats,
    required this.requests,
    this.notifications,
  });
}

class AdminError extends AdminState {
  final String message;

  AdminError(this.message);
}

class AdminActionLoading extends AdminState {}

class AdminActionSuccess extends AdminState {
  final String message;
  final String? id;
  final String? action; // 'delete', 'toggle_product', 'toggle_brand'
  AdminActionSuccess(this.message, {this.id, this.action});
}

class AdminActionError extends AdminState {
  final String message;
  AdminActionError(this.message);
}

class AdminOrdersLoading extends AdminState {}

class AdminOrdersSuccess extends AdminState {
  final List<AdminOrderModel> orders;
  AdminOrdersSuccess(this.orders);
}

class AdminOrdersError extends AdminState {
  final String message;
  AdminOrdersError(this.message);
}
