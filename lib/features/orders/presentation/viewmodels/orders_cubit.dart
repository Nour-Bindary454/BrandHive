import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/orders_repository.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepository _repository;

  OrdersCubit(this._repository) : super(OrdersInitial());

  Future<void> fetchMyOrders() async {
    emit(OrdersLoading());
    final result = await _repository.getMyOrders();
    result.fold(
      (failure) => emit(OrdersError(failure.errMessage)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  Future<void> fetchOrderDetails(String orderId) async {
    emit(OrderDetailsLoading());
    final result = await _repository.getOrderDetails(orderId);
    result.fold(
      (failure) => emit(OrderDetailsError(failure.errMessage)),
      (order) => emit(OrderDetailsLoaded(order)),
    );
  }

  Future<void> cancelOrder(String orderId, String reason) async {
    emit(OrderActionLoading());
    final result = await _repository.cancelOrder(orderId, reason);
    result.fold(
      (failure) => emit(OrderActionError(failure.errMessage)),
      (_) {
        emit(const OrderActionSuccess('Order cancelled successfully'));
        fetchOrderDetails(orderId);
      },
    );
  }

  Future<void> retryPayment(String orderId) async {
    emit(OrderActionLoading());
    final result = await _repository.retryPayment(orderId);
    result.fold(
      (failure) => emit(OrderActionError(failure.errMessage)),
      (response) {
        if (response.paymentUrl != null) {
          emit(PaymentRetrySuccess(response.paymentUrl!));
        } else {
          emit(const OrderActionError('Payment URL not found'));
        }
      },
    );
  }

  /// Simulate payment success for testing
  Future<void> simulatePaymentSuccess(String orderId, double amount) async {
    emit(OrderActionLoading());
    final result = await _repository.simulatePaymentWebhook(orderId, amount);
    result.fold(
      (failure) => emit(OrderActionError(failure.errMessage)),
      (_) {
        emit(const OrderActionSuccess('Payment simulation successful'));
        fetchOrderDetails(orderId);
      },
    );
  }

  // Admin endpoints
  Future<void> fetchAllAdminOrders() async {
    emit(OrdersLoading());
    final result = await _repository.getAllAdminOrders();
    result.fold(
      (failure) => emit(OrdersError(failure.errMessage)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  Future<void> updateOrderStatus(String orderId, String status, String note) async {
    emit(OrderActionLoading());
    final result = await _repository.updateOrderStatus(orderId, status, note);
    result.fold(
      (failure) => emit(OrderActionError(failure.errMessage)),
      (_) {
        emit(const OrderActionSuccess('Order status updated successfully'));
        fetchOrderDetails(orderId);
      },
    );
  }
}
