import 'package:brand/features/coupon/data/models/coupon_model.dart';
import 'package:brand/features/coupon/domain/repository/coupon_repository.dart';
import 'package:brand/features/coupon/presentation/cubit/coupon_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponCubit extends Cubit<CouponState> {
  final CouponRepository _repo;

  CouponCubit(this._repo) : super(CouponInitial());

  List<CouponModel> coupons = [];
  int currentPage = 1;
  int totalPages = 1;
  int total = 0;
  bool? activeFilter;
  bool sellerMode = false;

  void initSellerCoupons() {
    sellerMode = true;
    coupons = [];
    total = 0;
    currentPage = 1;
    totalPages = 1;
    emit(CouponsLoaded(
      coupons: coupons,
      total: total,
      page: currentPage,
      totalPages: totalPages,
    ));
  }

  Future<void> getCoupons({
    bool isRefresh = false,
    int page = 1,
    int limit = 10,
    bool? isActive,
  }) async {
    if (isRefresh) {
      currentPage = 1;
      coupons = [];
    }

    activeFilter = isActive;
    emit(CouponsLoading());

    final result = await _repo.getAllCoupons(
      page: page,
      limit: limit,
      isActive: isActive,
    );

    result.fold(
      (failure) => emit(CouponsFailure(failure.errMessage)),
      (response) {
        currentPage = response.page;
        totalPages = response.totalPages;
        total = response.total;
        if (page == 1) {
          coupons = response.coupons;
        } else {
          coupons.addAll(response.coupons);
        }
        emit(CouponsLoaded(
          coupons: coupons,
          total: total,
          page: currentPage,
          totalPages: totalPages,
        ));
      },
    );
  }

  Future<void> loadMore({int limit = 10}) async {
    if (currentPage >= totalPages) return;
    await getCoupons(
      page: currentPage + 1,
      limit: limit,
      isActive: activeFilter,
    );
  }

  Future<bool> createCoupon({
    required String code,
    required String type,
    required double value,
    required DateTime expiresAt,
    String? description,
    double? minOrderAmount,
  }) async {
    emit(CouponActionLoading());

    final body = {
      'code': code.trim().toUpperCase(),
      'type': type,
      'value': value,
      'expiresAt':
          '${expiresAt.year}-${expiresAt.month.toString().padLeft(2, '0')}-${expiresAt.day.toString().padLeft(2, '0')}',
      if (description != null && description.isNotEmpty)
        'description': description,
      if (minOrderAmount != null && minOrderAmount > 0)
        'minOrderAmount': minOrderAmount,
    };

    final result = await _repo.createCoupon(body);

    return result.fold(
      (failure) {
        emit(CouponActionFailure(failure.errMessage));
        return false;
      },
      (coupon) {
        emit(CouponActionSuccess('Coupon created successfully'));
        if (sellerMode) {
          coupons = [coupon, ...coupons];
          total = coupons.length;
          emit(CouponsLoaded(
            coupons: coupons,
            total: total,
            page: 1,
            totalPages: 1,
          ));
        } else {
          getCoupons(isRefresh: true, isActive: activeFilter);
        }
        return true;
      },
    );
  }

  Future<bool> updateCoupon({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    emit(CouponActionLoading());

    final result = await _repo.updateCoupon(id, body);

    return result.fold(
      (failure) {
        emit(CouponActionFailure(failure.errMessage));
        return false;
      },
      (_) {
        emit(CouponActionSuccess('Coupon updated successfully'));
        getCoupons(isRefresh: true, isActive: activeFilter);
        return true;
      },
    );
  }

  Future<void> toggleCouponStatus(CouponModel coupon) async {
    await updateCoupon(
      id: coupon.id,
      body: {'isActive': !coupon.isActive},
    );
  }

  Future<void> deleteCoupon(String id) async {
    emit(CouponActionLoading());

    final result = await _repo.deleteCoupon(id);

    result.fold(
      (failure) => emit(CouponActionFailure(failure.errMessage)),
      (_) async {
        emit(CouponActionSuccess('Coupon deleted successfully'));
        await getCoupons(isRefresh: true, isActive: activeFilter);
      },
    );
  }

  Future<void> validateCoupon({
    required String code,
    required double orderAmount,
  }) async {
    emit(CouponValidating());

    final result = await _repo.validateCoupon(
      code: code,
      orderAmount: orderAmount,
    );

    result.fold(
      (failure) => emit(CouponValidationFailure(failure.errMessage)),
      (validation) {
        if (!validation.isValid) {
          emit(CouponValidationFailure(
            validation.message ?? 'Invalid coupon code',
          ));
          return;
        }
        emit(CouponValidated(validation));
      },
    );
  }
}
