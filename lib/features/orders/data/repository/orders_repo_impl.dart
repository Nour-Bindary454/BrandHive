import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/orders/data/models/user_order_model.dart';
import 'package:brand/features/orders/data/repository/orders_repo.dart';
import 'package:dartz/dartz.dart';

class OrdersRepoImpl implements OrdersRepo {
  final ApiService api;

  OrdersRepoImpl(this.api);

  @override
  Future<Either<Failure, List<UserOrderModel>>> getMyOrders() async {
    try {
      final response = await api.getData(endPoint: EndPoints.myOrders);
      final List data = response.data['data'] ?? [];
      final orders = data.map((e) => UserOrderModel.fromJson(e)).toList();
      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
