import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/orderSuccess/widgets/items_ordered_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC), // Light grayish-blue background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60.h),
              
              // Success Icon
              Container(
                width: 80.r,
                height: 80.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFADD487), // Light green
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: const Color(0xFF135029), // Dark green check
                  size: 40.r,
                  weight: 700,
                ),
              ),
              
              SizedBox(height: 30.h),
              
              // Titles
              BasicText(
                text: 'order_placed'.tr().tr(),
                fontSize: 24,
                color: Color(0xFF2D4373), // Dark Blue
                isBold: true,
              ),
              SizedBox(height: 10.h),
              BasicText(
                text: 'thank_you_for_your_purchase'.tr().tr(),
                fontSize: 14,
                color: Colors.grey.shade800,
                isBold: false, 
              ),
              SizedBox(height: 5.h),
              BasicText(
                text: 'order_egy_8839201_confirmed'.tr().tr(),
                fontSize: 12,
                color: Colors.grey.shade500,
                isBold: false, 
              ),
              
              SizedBox(height: 40.h),
              
              // Items Card
              const ItemsOrderedCard(),
              
              const Spacer(),
              
              // Buttons
              // Trace Order Outline Button
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: const Color(0xFF2D4373), width: 1), // Dark blue border
                  ),
                  child: Center(
                    child: Text(
                      'Trace Order',
                      style: TextStyle(
                        color: const Color(0xFF2D4373),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500, // Matching typical BasicButton feel
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 15.h),
              
              // Continue Shopping Filled Button
              BasicButton(
                text: 'continue_shopping'.tr().tr(),
                colors: const [Color(0xFF2D4373)],
                radius: 25.r,
                onPressed: () {},
              ),
              
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
