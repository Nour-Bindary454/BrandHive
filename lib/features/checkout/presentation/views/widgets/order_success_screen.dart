import 'package:brand/features/checkout/data/models/checkout_response_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';

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
              SizedBox(height: 20.h),

              /// 🔵 Success Icon
              Container(
                height: 80.r,
                width: 80.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFC7E5A8),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.green, size: 40.sp),
              ),

              SizedBox(height: 24.h),

              /// 🔹 Title
              Text(
                'Order Placed!',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  color:
                      Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                'Thank you for your purchase.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),

              SizedBox(height: 4.h),

              Text(
                'Order #${response.data.orderNumber ?? response.data.id ?? "N/A"}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFCBA153),
                ),
              ),

              SizedBox(height: 40.h),

              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ITEMS ORDERED',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ...response.data.items
                        .map(
                          (item) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8.r),
                                    image: item.productImage != null
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              item.productImage!,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productName,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Qty: ${item.quantity}',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${item.unitPrice.toStringAsFixed(0)} EGP',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),

              SizedBox(height: 60.h),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Navigate to Orders
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2D4373)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    'trace_order'.tr(),
                    style: const TextStyle(color: Color(0xFF2D4373)),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              BasicButton(
                text: 'continue_shopping'.tr(),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                colors: const [Color(0xFF2D4373)],
                radius: 25.r,
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
