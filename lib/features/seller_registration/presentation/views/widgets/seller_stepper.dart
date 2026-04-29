import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerStepper extends StatelessWidget {
  final int currentStep; // 0 to 3

  const SellerStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStep(0, 'Personal', Icons.person_outline),
          _buildLine(0),
          _buildStep(1, 'Store', Icons.store_outlined),
          _buildLine(1),
          _buildStep(2, 'Address', Icons.location_on_outlined),
          _buildLine(2),
          _buildStep(3, 'Documents', Icons.description_outlined),
        ],
      ),
    );
  }

  Widget _buildStep(int stepIndex, String title, IconData icon) {
    bool isCompleted = stepIndex < currentStep;
    bool isActive = stepIndex == currentStep;

    Color iconColor = isActive || isCompleted ? Colors.white : const Color(0xFF2D4373);
    Color circleColor = isActive || isCompleted ? const Color(0xFF2D4373) : const Color(0xFFF2F4F7);
    Color textColor = isActive || isCompleted ? const Color(0xFF2D4373) : const Color(0xFF8E8E8E);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? const Color(0xFF2D4373) : Colors.transparent,
              width: 2.w,
            ),
          ),
          child: Center(
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: iconColor,
              size: 20.sp,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildLine(int stepIndex) {
    bool isCompleted = stepIndex < currentStep;
    return Expanded(
      child: Container(
        height: 2.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 24.h), // aligned with circles
        color: isCompleted ? const Color(0xFF2D4373) : const Color(0xFFE5E5E5),
      ),
    );
  }
}
