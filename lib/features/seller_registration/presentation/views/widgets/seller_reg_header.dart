import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/seller_stepper.dart';

class SellerRegHeader extends StatelessWidget {
  final int currentStep;
  final VoidCallback onBack;

  const SellerRegHeader({
    super.key,
    required this.currentStep,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Background
        Container(
          height: 220.h,
          width: double.infinity,
          color: const Color(0xFF2D4373),
        ),
      ],
    );
  }
}

class SellerRegHeaderContent extends StatelessWidget {
  final int currentStep;
  final VoidCallback onBack;

  const SellerRegHeaderContent({
    super.key,
    required this.currentStep,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row - Back + Step counter
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),
              Text(
                'Step ${currentStep + 1} of 3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ),
        ),
        SizedBox(height: 20.h),

        // Title + Subtitle
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seller Registration',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Fill in your details to join as a seller',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Stepper
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SellerStepper(currentStep: currentStep),
        ),
      ],
    );
  }
}
