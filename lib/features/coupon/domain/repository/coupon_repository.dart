import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/coupon/data/models/coupon_model.dart';
import 'package:dartz/dartz.dart';

abstract class CouponRepository {
  Future<Either<Failure, CouponsListResponse>> getAllCoupons({
    int page = 1,
    int limit = 10,
    bool? isActive,
  });

  Future<Either<Failure, CouponModel>> getCouponById(String id);

  Future<Either<Failure, CouponModel>> createCoupon(Map<String, dynamic> body);

  Future<Either<Failure, CouponModel>> updateCoupon(
    String id,
    Map<String, dynamic> body,
  );

  Future<Either<Failure, void>> deleteCoupon(String id);

  Future<Either<Failure, CouponValidationResult>> validateCoupon({
    required String code,
    required double orderAmount,
  });
}
