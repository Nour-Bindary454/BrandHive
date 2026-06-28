import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerRegistrationSuccessView extends StatelessWidget {
  const SellerRegistrationSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circle with Checkmark
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D4373).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2D4373),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 40.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                
                // Success Title
                Text(
                  'Application Submitted',
                  style: TextStyle(
                    color: const Color(0xFF2B2B2B),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 16.h),
                
                // Success Message
                Text(
                  'Your request has been received and we will review your application. We will respond within 48 hours.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF8E8E8E),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 48.h),
                
                // Back to Profile / Home Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate back to profile or home
                      Navigator.pushNamedAndRemoveUntil(context, '/mainlayout', (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D4373),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
