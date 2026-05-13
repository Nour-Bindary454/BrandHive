import 'package:brand/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:brand/features/checkout/data/models/order_model.dart';
import 'package:brand/features/checkout/data/models/checkout_response_model.dart';
import '../data_sources/orders_remote_data_source.dart';

class OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepository(this._remoteDataSource);

  Future<Either<Failure, List<OrderModel>>> getMyOrders() async {
    try {
      final orders = await _remoteDataSource.getMyOrders();
      return Right(orders);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, OrderModel>> getOrderDetails(String orderId) async {
    try {
      final order = await _remoteDataSource.getOrderDetails(orderId);
      return Right(order);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> cancelOrder(String orderId, String reason) async {
    try {
      await _remoteDataSource.cancelOrder(orderId, reason);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, CheckoutResponseModel>> retryPayment(String orderId) async {
    try {
      final response = await _remoteDataSource.retryPayment(orderId);
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  // Admin
  Future<Either<Failure, List<OrderModel>>> getAllAdminOrders() async {
    try {
      final orders = await _remoteDataSource.getAllAdminOrders();
      return Right(orders);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, OrderModel>> updateOrderStatus(String orderId, String status, String note) async {
    try {
      final order = await _remoteDataSource.updateOrderStatus(orderId, status, note);
      return Right(order);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
