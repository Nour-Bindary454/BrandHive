import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/orders_repo.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo repo;

  OrdersCubit(this.repo) : super(OrdersInitial());

  Future<void> getMyOrders() async {
    emit(OrdersLoading());

    final result = await repo.getMyOrders();

    result.fold(
      (failure) {
        emit(OrdersError(failure.errMessage));
      },
      (orders) {
        emit(OrdersSuccess(orders));
      },
    );
  }
}
