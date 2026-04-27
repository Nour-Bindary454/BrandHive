import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/sharedWidgets/basic_colors.dart';
import '../../../../../core/sharedWidgets/basic_text.dart';

class CheckoutStepIndicator extends StatelessWidget {
  final int currentStep;

  const CheckoutStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStepItem(1, 'SHIPPING'),
          _buildStepLine(1),
          _buildStepItem(2, 'PAYMENT'),
          _buildStepLine(2),
          _buildStepItem(3, 'REVIEW'),
        ],
      ),
    );
  }

  Widget _buildStepItem(int stepIndex, String title) {
    bool isActive = currentStep >= stepIndex;

    final color = isActive ? BasicColors.buttonColorLight : Colors.grey[400]!;

    return Column(
      children: [
        CircleAvatar(
          radius: 16.r,
          backgroundColor: color,
          child: BasicText(
            text: stepIndex.toString(),
            fontSize: 14.sp,
            color: Colors.white,
            isBold: true,
          ),
        ),
        SizedBox(height: 8.h),
        BasicText(text: title, fontSize: 10.sp, color: color, isBold: true),
      ],
    );
  }

  Widget _buildStepLine(int stepIndex) {
    bool isActive = currentStep > stepIndex;

    return Expanded(
      child: Container(
        height: 2.h,
        margin: EdgeInsets.only(bottom: 20.h, left: 8.w, right: 8.w),
        color: isActive ? BasicColors.buttonColorDark : Colors.grey[300],
      ),
    );
  }
}
