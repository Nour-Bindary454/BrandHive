import 'package:brand/features/coupon/data/models/coupon_model.dart';

abstract class CouponState {}

class CouponInitial extends CouponState {}

class CouponsLoading extends CouponState {}

class CouponsLoaded extends CouponState {
  final List<CouponModel> coupons;
  final int total;
  final int page;
  final int totalPages;

  CouponsLoaded({
    required this.coupons,
    required this.total,
    required this.page,
    required this.totalPages,
  });
}

class CouponsFailure extends CouponState {
  final String message;
  CouponsFailure(this.message);
}

class CouponActionLoading extends CouponState {}

class CouponActionSuccess extends CouponState {
  final String message;
  CouponActionSuccess(this.message);
}

class CouponActionFailure extends CouponState {
  final String message;
  CouponActionFailure(this.message);
}

class CouponValidating extends CouponState {}

class CouponValidated extends CouponState {
  final CouponValidationResult result;
  CouponValidated(this.result);
}

class CouponValidationFailure extends CouponState {
  final String message;
  CouponValidationFailure(this.message);
}
