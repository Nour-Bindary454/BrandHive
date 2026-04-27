import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/sharedWidgets/basic_colors.dart';

import '../../viewmodels/checkout_view_model.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CheckoutViewModel>();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: BasicColors.black,
              ),
            ),
            SizedBox(height: 20.h),

            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: BasicColors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SHIPPING TO',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${viewModel.selectedAddress?.fullName}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${viewModel.selectedAddress?.fullAddress}\n${viewModel.selectedAddress?.phoneNumber}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 20.h),
                  const Divider(),
                  SizedBox(height: 20.h),

                  Text(
                    'PAYMENT METHOD',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 20.sp,
                        color: (BasicColors.buttonColorDark),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        viewModel.selectedPayment?.displayMethodName ?? '',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                  const Divider(),
                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                      Text(
                        '${(viewModel.totalAmount - 50).toStringAsFixed(0)} EGP',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping Fee',
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                      Text('50 EGP', style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        '${viewModel.totalAmount.toStringAsFixed(0)} EGP',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16.sp,
                          color: (BasicColors.buttonColorDark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: const Color(0xFFCBA153).withOpacity(0.8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_shipping,
                    color: BasicColors.black,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Estimated Delivery: 2-3 Business Days',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: BasicColors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
