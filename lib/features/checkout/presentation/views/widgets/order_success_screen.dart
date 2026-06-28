import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:brand/features/checkout/data/models/checkout_response_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:provider/provider.dart';

class OrderSuccessScreen extends StatelessWidget {
  final CheckoutResponseModel response;

  const OrderSuccessScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),

              /// 🔵 Success Icon
              Container(
                height: 100.r,
                width: 100.r,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 60.sp,
                ),
              ),

              SizedBox(height: 24.h),

              /// 🔹 Title
              Text(
                'Order Placed!',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontFamily: 'Outfit',
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                'Thank you for your purchase.',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey,
                  fontFamily: 'Outfit',
                ),
              ),

              SizedBox(height: 12.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: BasicColors.buttonColorLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Order #${response.data.orderNumber ?? response.data.id ?? "N/A"}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: BasicColors.buttonColorLight,
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              /// 🔹 Order Summary Card
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ORDER SUMMARY',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ...response.data.items.map(
                      (item) => Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Row(
                          children: [
                            Container(
                              width: 55.w,
                              height: 55.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12.r),
                                image: item.productImage != null
                                    ? DecorationImage(
                                        image: NetworkImage(item.productImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.productName,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Quantity: ${item.quantity}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${item.unitPrice.toStringAsFixed(0)} EGP',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w900,
                                color: BasicColors.buttonColorLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${response.data.subtotal.toStringAsFixed(0)} EGP',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w900,
                            color: BasicColors.buttonColorLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              /// 🔹 Buttons
              BasicButton(
                text: 'continue_shopping'.tr(),
                onPressed: () {
                  // Clear cart UI state
                  context.read<CartViewModel>().clearCartLocal();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                colors: const [
                  BasicColors.linearGradientDark,
                  BasicColors.linearGradientLight,
                ],
                radius: 25.r,
              ),

              SizedBox(height: 16.h),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushNamed(context, '/orders');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: BasicColors.buttonColorLight,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    'trace_order'.tr(),
                    style: TextStyle(
                      color: BasicColors.buttonColorLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
