import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutBottomBar extends StatelessWidget {
  final int currentStep;
  final VoidCallback onNext;
  final double totalPrice;
  final bool isLoading;

  const CheckoutBottomBar({
    super.key,
    required this.currentStep,
    required this.onNext,
    required this.totalPrice,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Payment',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${totalPrice.toStringAsFixed(0)} EGP',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: BasicColors.buttonColorLight,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          BasicButton(
            text: currentStep == 3 ? "Place Order" : "Continue",
            onPressed: onNext,
            isLoading: isLoading,
            colors: const [
              BasicColors.linearGradientDark,
              BasicColors.linearGradientLight,
            ],
            radius: 25.r,
          ),
        ],
      ),
    );
  }
}
