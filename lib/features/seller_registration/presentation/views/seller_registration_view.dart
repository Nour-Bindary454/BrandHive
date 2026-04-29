import 'package:brand/features/seller_registration/presentation/views/widgets/seller_bottom_navigation.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/seller_stepper.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/steps/address_info_step.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/steps/documents_step.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/steps/personal_info_step.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/steps/store_info_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerRegistrationView extends StatefulWidget {
  const SellerRegistrationView({super.key});

  @override
  State<SellerRegistrationView> createState() => _SellerRegistrationViewState();
}

class _SellerRegistrationViewState extends State<SellerRegistrationView> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  final List<Widget> _steps = const [
    PersonalInfoStep(),
    StoreInfoStep(),
    AddressInfoStep(),
    DocumentsStep(),
  ];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to success screen after step 4
      Navigator.pushReplacementNamed(context, '/sellerRegistrationSuccess');
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context); // Exit registration if on step 1
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Very light grey bg from image
      body: Stack(
        children: [
          // Header Background (Dark Blue)
          Container(
            height: 220.h,
            width: double.infinity,
            color: const Color(0xFF2D4373),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Header Content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _previousStep,
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
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
                        'Step ${_currentStep + 1} of 4',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(width: 40.w), // Placeholder to balance the row
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
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
                
                // Stepper overlapping the header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SellerStepper(currentStep: _currentStep),
                ),
                
                // Form Content
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 24.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.r),
                        topRight: Radius.circular(32.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(), // Disable swipe
                            children: _steps.map((step) {
                              return SingleChildScrollView(
                                padding: EdgeInsets.all(24.w),
                                child: step,
                              );
                            }).toList(),
                          ),
                        ),
                        // Bottom Navigation
                        Padding(
                          padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
                          child: SellerBottomNavigation(
                            onBack: _previousStep,
                            onContinue: _nextStep,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
