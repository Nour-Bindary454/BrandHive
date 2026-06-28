import 'package:brand/features/orders/data/models/user_order_model.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {
  final List<UserOrderModel> orders;

  OrdersSuccess(this.orders);
}

class OrdersError extends OrdersState {
  final String errMessage;

  OrdersError(this.errMessage);
}
