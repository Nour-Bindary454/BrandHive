import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/coupon/domain/repository/coupon_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponInputWidget extends StatefulWidget {
  final double orderAmount;
  final void Function(String code, double discount)? onCouponApplied;
  final VoidCallback? onCouponRemoved;

  const CouponInputWidget({
    super.key,
    required this.orderAmount,
    this.onCouponApplied,
    this.onCouponRemoved,
  });

  @override
  State<CouponInputWidget> createState() => _CouponInputWidgetState();
}

class _CouponInputWidgetState extends State<CouponInputWidget> {
  final _controller = TextEditingController();
  bool _isLoading = false;
  String? _appliedCode;
  double _discount = 0;

  String _friendlyError(String message) {
    final normalized = message.toLowerCase();
    if (normalized.contains('not found') ||
        normalized.contains('invalid') ||
        normalized.contains('expired') ||
        normalized.contains('inactive')) {
      return 'coupon_invalid'.tr();
    }
    if (message.length > 120 ||
        normalized.contains('dioexception') ||
        normalized.contains('socketexception')) {
      return 'coupon_invalid'.tr();
    }
    return message;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _applyCoupon() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;

    setState(() => _isLoading = true);

    final result = await sl<CouponRepository>().validateCoupon(
      code: code,
      orderAmount: widget.orderAmount,
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        Toast.showErrorToast(
          msg: _friendlyError(failure.errMessage),
          context: context,
        );
        setState(() => _isLoading = false);
      },
      (validation) {
        if (!validation.isValid) {
          Toast.showErrorToast(
            msg: validation.message ?? 'coupon_invalid'.tr(),
            context: context,
          );
          setState(() => _isLoading = false);
          return;
        }

        var discount = validation.discountAmount;
        if (discount <= 0 && validation.coupon != null) {
          final coupon = validation.coupon!;
          if (coupon.isPercentage) {
            discount = widget.orderAmount * coupon.value / 100;
            if (coupon.maxDiscountAmount != null) {
              discount = discount.clamp(0, coupon.maxDiscountAmount!);
            }
          } else {
            discount = coupon.value;
          }
        }

        setState(() {
          _isLoading = false;
          _appliedCode = code.toUpperCase();
          _discount = discount;
        });

        widget.onCouponApplied?.call(code.toUpperCase(), discount);
        Toast.showSuccessToast(
          msg: 'coupon_applied'.tr(args: [discount.toStringAsFixed(0)]),
          context: context,
        );
      },
    );
  }

  void _removeCoupon() {
    setState(() {
      _appliedCode = null;
      _discount = 0;
      _controller.clear();
    });
    widget.onCouponRemoved?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: _appliedCode != null
              ? const Color(0xFF059669)
              : Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_offer_outlined,
                size: 20.sp,
                color: const Color(0xFF2D4373),
              ),
              SizedBox(width: 8.w),
              Text(
                'apply_coupon'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (_appliedCode != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: const Color(0xFF059669), size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _appliedCode!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: const Color(0xFF065F46),
                          ),
                        ),
                        Text(
                          '-${_discount.toStringAsFixed(0)} EGP',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF059669),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _removeCoupon,
                    child: Text(
                      'remove'.tr(),
                      style: const TextStyle(color: Color(0xFFEF4444)),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'coupon_code_hint'.tr(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  height: 46.h,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _applyCoupon,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D4373),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text('apply'.tr()),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
