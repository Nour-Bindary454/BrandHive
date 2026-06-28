import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/coupon/data/models/coupon_model.dart';
import 'package:brand/features/coupon/domain/repository/coupon_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CouponRepositoryImpl implements CouponRepository {
  final ApiService apiService;

  CouponRepositoryImpl(this.apiService);

  Failure _mapError(Object error) {
    if (error is DioException) {
      if (error.error is Failure) {
        return error.error as Failure;
      }
      return ServerFailure.fromDioError(error);
    }
    return ServerFailure('Something went wrong. Please try again');
  }

  @override
  Future<Either<Failure, CouponsListResponse>> getAllCoupons({
    int page = 1,
    int limit = 10,
    bool? isActive,
  }) async {
    try {
      final query = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (isActive != null) 'isActive': isActive,
      };

      final response = await apiService.getData(
        endPoint: EndPoints.couponsAdminAll,
        query: query,
      );

      return right(CouponsListResponse.fromJson(response.data));
    } catch (e) {
      return left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, CouponModel>> getCouponById(String id) async {
    try {
      final response = await apiService.getData(
        endPoint: EndPoints.couponAdminDetail(id),
      );
      final raw = response.data['data'] ?? response.data;
      return right(CouponModel.fromJson(raw));
    } catch (e) {
      return left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, CouponModel>> createCoupon(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.coupons,
        data: body,
      );
      final raw = response.data['data'] ?? response.data;
      return right(CouponModel.fromJson(raw));
    } catch (e) {
      return left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, CouponModel>> updateCoupon(
    String id,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await apiService.putData(
        endPoint: EndPoints.couponById(id),
        data: body,
      );
      final raw = response.data['data'] ?? response.data;
      return right(CouponModel.fromJson(raw));
    } catch (e) {
      return left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCoupon(String id) async {
    try {
      await apiService.deleteData(endPoint: EndPoints.couponById(id));
      return right(null);
    } catch (e) {
      return left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, CouponValidationResult>> validateCoupon({
    required String code,
    required double orderAmount,
  }) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.couponsValidate,
        data: {
          'code': code.trim().toUpperCase(),
          'orderAmount': orderAmount,
        },
      );
      return right(CouponValidationResult.fromJson(response.data));
    } catch (e) {
      return left(_mapError(e));
    }
  }
}
