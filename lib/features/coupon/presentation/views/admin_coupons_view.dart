import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/coupon/data/models/coupon_model.dart';
import 'package:brand/features/coupon/presentation/cubit/coupon_cubit.dart';
import 'package:brand/features/coupon/presentation/cubit/coupon_states.dart';
import 'package:brand/features/coupon/presentation/views/widgets/coupon_card.dart';
import 'package:brand/features/coupon/presentation/views/widgets/coupon_form_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminCouponsView extends StatefulWidget {
  const AdminCouponsView({super.key});

  @override
  State<AdminCouponsView> createState() => _AdminCouponsViewState();
}

class _AdminCouponsViewState extends State<AdminCouponsView> {
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    context.read<CouponCubit>().getCoupons(isRefresh: true);
  }

  bool? get _isActiveFilter {
    if (_filter == 'active') return true;
    if (_filter == 'inactive') return false;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'manage_coupons'.tr(),
          style: TextStyle(
            color: const Color(0xFF1E293B),
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateDialog(context),
        backgroundColor: const Color(0xFF2D4373),
        icon: const Icon(Icons.add),
        label: Text('create_coupon'.tr()),
      ),
      body: BlocConsumer<CouponCubit, CouponState>(
        listener: (context, state) {
          if (state is CouponActionSuccess) {
            Toast.showSuccessToast(msg: state.message, context: context);
          } else if (state is CouponActionFailure) {
            Toast.showErrorToast(msg: state.message, context: context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<CouponCubit>();

          return Column(
            children: [
              _buildFilterChips(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    Icon(Icons.local_offer, color: const Color(0xFF2D4373), size: 18.sp),
                    SizedBox(width: 6.w),
                    Text(
                      '${cubit.total} ${'coupons'.tr()}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: state is CouponsLoading && cubit.coupons.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(color: Color(0xFF2D4373)),
                      )
                    : state is CouponsFailure && cubit.coupons.isEmpty
                        ? _buildError(state.message)
                        : cubit.coupons.isEmpty
                            ? _buildEmpty()
                            : RefreshIndicator(
                                onRefresh: () => cubit.getCoupons(
                                  isRefresh: true,
                                  isActive: _isActiveFilter,
                                ),
                                child: ListView.builder(
                                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
                                  physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  itemCount: cubit.coupons.length,
                                  itemBuilder: (context, index) {
                                    final coupon = cubit.coupons[index];
                                    return CouponCard(
                                      coupon: coupon,
                                      onEdit: () => _showEditDialog(context, coupon),
                                      onDelete: () => _confirmDelete(context, coupon),
                                      onToggle: () => cubit.toggleCouponStatus(coupon),
                                    );
                                  },
                                ),
                              ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          _chip('all', 'filter_all'.tr()),
          _chip('active', 'coupon_active'.tr()),
          _chip('inactive', 'coupon_inactive'.tr()),
        ],
      ),
    );
  }

  Widget _chip(String value, String label) {
    final selected = _filter == value;
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {
          setState(() => _filter = value);
          context.read<CouponCubit>().getCoupons(
                isRefresh: true,
                isActive: _isActiveFilter,
              );
        },
        selectedColor: const Color(0xFF2D4373).withOpacity(0.15),
        checkmarkColor: const Color(0xFF2D4373),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_offer_outlined, size: 64.sp, color: Colors.grey.shade300),
          SizedBox(height: 12.h),
          Text('no_coupons_found'.tr(), style: TextStyle(color: Colors.grey.shade500)),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, textAlign: TextAlign.center),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () => context.read<CouponCubit>().getCoupons(isRefresh: true),
            child: Text('try_again'.tr()),
          ),
        ],
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    CouponFormDialog.show(
      context,
      onSubmit: ({
        required code,
        required type,
        required value,
        required expiresAt,
        description,
        minOrderAmount,
      }) {
        return context.read<CouponCubit>().createCoupon(
              code: code,
              type: type,
              value: value,
              expiresAt: expiresAt,
              description: description,
              minOrderAmount: minOrderAmount,
            );
      },
    );
  }

  void _showEditDialog(BuildContext context, CouponModel coupon) {
    CouponFormDialog.show(
      context,
      coupon: coupon,
      onSubmit: ({
        required code,
        required type,
        required value,
        required expiresAt,
        description,
        minOrderAmount,
      }) {
        return context.read<CouponCubit>().updateCoupon(
              id: coupon.id,
              body: {
                'type': type,
                'value': value,
                'expiresAt':
                    '${expiresAt.year}-${expiresAt.month.toString().padLeft(2, '0')}-${expiresAt.day.toString().padLeft(2, '0')}',
                if (description != null && description.isNotEmpty)
                  'description': description,
                if (minOrderAmount != null) 'minOrderAmount': minOrderAmount,
              },
            );
      },
    );
  }

  void _confirmDelete(BuildContext context, CouponModel coupon) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('delete_coupon'.tr()),
        content: Text('delete_coupon_confirm'.tr(args: [coupon.code])),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CouponCubit>().deleteCoupon(coupon.id);
            },
            child: Text('delete'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class SellerCouponsView extends StatelessWidget {
  const SellerCouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CouponCubit>()..initSellerCoupons(),
      child: const _SellerCouponsBody(),
    );
  }
}

class _SellerCouponsBody extends StatelessWidget {
  const _SellerCouponsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'store_coupons'.tr(),
          style: TextStyle(
            color: const Color(0xFF1F2937),
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          CouponFormDialog.show(
            context,
            onSubmit: ({
              required code,
              required type,
              required value,
              required expiresAt,
              description,
              minOrderAmount,
            }) {
              return context.read<CouponCubit>().createCoupon(
                    code: code,
                    type: type,
                    value: value,
                    expiresAt: expiresAt,
                    description: description,
                    minOrderAmount: minOrderAmount,
                  );
            },
          );
        },
        backgroundColor: const Color(0xFF2D4373),
        icon: const Icon(Icons.add),
        label: Text('create_coupon'.tr()),
      ),
      body: BlocConsumer<CouponCubit, CouponState>(
        listener: (context, state) {
          if (state is CouponActionSuccess) {
            Toast.showSuccessToast(msg: state.message, context: context);
          } else if (state is CouponActionFailure) {
            Toast.showErrorToast(msg: state.message, context: context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<CouponCubit>();

          if (state is CouponsLoading && cubit.coupons.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2D4373)),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFBFDBFE)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: const Color(0xFF2563EB), size: 20.sp),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'seller_coupon_hint'.tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF1E40AF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: cubit.coupons.isEmpty
                    ? Center(child: Text('no_coupons_found'.tr()))
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: cubit.coupons.length,
                        itemBuilder: (context, index) {
                          return CouponCard(
                            coupon: cubit.coupons[index],
                            showActions: false,
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
