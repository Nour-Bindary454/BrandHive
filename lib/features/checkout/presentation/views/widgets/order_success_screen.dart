import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/sharedWidgets/basic_colors.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BasicColors.white,

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
                  color: BasicColors.black,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                'Thank you for your purchase.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),

              SizedBox(height: 4.h),

              Text(
                'Order confirmed successfully',
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),

              SizedBox(height: 40.h),

              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: BasicColors.white,
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

                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Name',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Qty: 1',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 60.h),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: null,
                  child: const Text('Trace Order'),
                ),
              ),

              SizedBox(height: 16.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: null,
                  child: const Text('Continue Shopping'),
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
