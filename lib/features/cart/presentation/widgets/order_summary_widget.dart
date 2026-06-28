import 'package:brand/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:brand/features/checkout/presentation/views/checkout_screen.dart';
import 'package:brand/features/coupon/presentation/views/widgets/coupon_input_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../checkout/data/models/order_item_model.dart';

class OrderSummaryWidget extends StatefulWidget {
  const OrderSummaryWidget({super.key});

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  double _couponDiscount = 0;
  String? _appliedCouponCode;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.items.isEmpty) {
          return const SizedBox.shrink();
        }

        final total = (viewModel.subtotal + viewModel.shippingCost - _couponDiscount)
            .clamp(0, double.infinity);

        return Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              SizedBox(height: 16.h),

              CouponInputWidget(
                orderAmount: viewModel.subtotal,
                onCouponApplied: (code, discount) {
                  setState(() {
                    _couponDiscount = discount;
                    _appliedCouponCode = code;
                  });
                },
                onCouponRemoved: () {
                  setState(() {
                    _couponDiscount = 0;
                    _appliedCouponCode = null;
                  });
                },
              ),

              SizedBox(height: 16.h),

              _buildSummaryRow(
                context,
                'Subtotal',
                '${viewModel.subtotal.toStringAsFixed(0)} EGP',
              ),

              SizedBox(height: 10.h),

              _buildSummaryRow(
                context,
                'Shipping',
                '${viewModel.shippingCost.toStringAsFixed(0)} EGP',
              ),

              if (_couponDiscount > 0) ...[
                SizedBox(height: 10.h),
                _buildSummaryRow(
                  context,
                  'coupon_discount'.tr(),
                  '-${_couponDiscount.toStringAsFixed(0)} EGP',
                  valueColor: const Color(0xFF059669),
                ),
              ],

              SizedBox(height: 16.h),

              Divider(color: Theme.of(context).dividerColor),

              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '${total.toStringAsFixed(0)} EGP',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: viewModel.isLoading
                      ? null
                      : () {
                          final orderItems = viewModel.items
                              .map(
                                (e) => OrderItemModel(
                                  productImage: e.image,
                                  itemTotal: e.price,
                                  productName: e.name,
                                  product: e.productId,
                                  unitPrice: e.price,
                                  quantity: e.quantity,
                                ),
                              )
                              .toList();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                items: orderItems,
                                subtotal: viewModel.subtotal,
                                couponCode: _appliedCouponCode,
                                couponDiscount: _couponDiscount,
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 0,
                  ),
                  child: viewModel.isLoading
                      ? SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : Text(
                          'Checkout (${total.toStringAsFixed(0)} EGP)',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String title,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: valueColor ?? Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
