import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminSuccess extends AdminState {
  final List<AdminStatModel> stats;
  final List<AdminBrandRequest> requests;

  AdminSuccess({required this.stats, required this.requests});
}

class AdminError extends AdminState {
  final String message;

  AdminError(this.message);
}

class AdminActionLoading extends AdminState {}
