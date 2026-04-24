import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutBottomBar extends StatelessWidget {
  final int currentStep;
  final VoidCallback onNext;
  final double totalPrice;

  const CheckoutBottomBar({
    super.key,
    required this.currentStep,
    required this.onNext,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 🔹 Total Payment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Payment',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color.fromARGB(255, 108, 111, 113),
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          Text(
            '$totalPrice EGP',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              color: BasicColors.buttonColorLight,
            ),
          ),

          SizedBox(height: 16.h),

          /// 🔹 Button (LOGIC ONLY)
          BasicButton(
            text: currentStep == 3 ? "Place Order" : "Continue",
            onPressed: onNext,
            colors: const [BasicColors.buttonColorLight],
            radius: 22.r,
          ),
        ],
      ),
    );
  }
}
