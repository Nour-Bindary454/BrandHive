import 'package:equatable/equatable.dart';
import 'package:brand/features/checkout/data/models/order_model.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderDetailsLoading extends OrdersState {}

class OrderDetailsLoaded extends OrdersState {
  final OrderModel order;

  const OrderDetailsLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderDetailsError extends OrdersState {
  final String message;

  const OrderDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderActionLoading extends OrdersState {}

class OrderActionSuccess extends OrdersState {
  final String message;

  const OrderActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderActionError extends OrdersState {
  final String message;

  const OrderActionError(this.message);

  @override
  List<Object?> get props => [message];
}

class PaymentRetrySuccess extends OrdersState {
  final String paymentUrl;

  const PaymentRetrySuccess(this.paymentUrl);

  @override
  List<Object?> get props => [paymentUrl];
}
