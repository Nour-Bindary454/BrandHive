import 'package:dartz/dartz.dart';
import 'package:brand/core/errors/failure.dart';
import '../models/user_order_model.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<UserOrderModel>>> getMyOrders();
}
