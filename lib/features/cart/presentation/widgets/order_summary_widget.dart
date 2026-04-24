import 'package:brand/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:brand/features/checkout/presentation/views/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/sharedWidgets/basic_colors.dart';

import '../../../checkout/data/models/order_item_model.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.items.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: BasicColors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
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
                  color: BasicColors.black,
                ),
              ),
              SizedBox(height: 16.h),
              _buildSummaryRow(
                'Subtotal',
                '${viewModel.subtotal.toStringAsFixed(0)} EGP',
              ),
              SizedBox(height: 10.h),
              _buildSummaryRow(
                'Shipping',
                '${viewModel.shippingCost.toStringAsFixed(0)} EGP',
              ),
              SizedBox(height: 16.h),
              const Divider(color: Color(0xFFEEEEEE)),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: BasicColors.black,
                    ),
                  ),
                  Text(
                    '${viewModel.total.toStringAsFixed(0)} EGP',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF2B3A5A), // Similar to design
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
                          // Map Cart models to Order item models for checkout
                          viewModel.items
                              .map(
                                (e) => OrderItemModel(
                                  id: e.id,
                                  name: e.name,
                                  price: e.price,
                                  quantity: e.quantity,
                                  image: e.image,
                                ),
                              )
                              .toList();

                          // Initialize Checkout Feature state

                          // Navigate to step 1
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CheckoutScreen(),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B3A5A),
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
                            color: BasicColors.white,
                          ),
                        )
                      : Text(
                          'Checkout (${viewModel.total.toStringAsFixed(0)} EGP)',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: BasicColors.white,
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

  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: BasicColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
