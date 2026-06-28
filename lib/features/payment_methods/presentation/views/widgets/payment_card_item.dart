import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCardItem extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color iconBgColor;
  final String cardNumber;
  final String expiryDate;
  final bool isDefault;

  const PaymentCardItem({
    super.key,
    required this.iconData,
    required this.iconColor,
    required this.iconBgColor,
    required this.cardNumber,
    required this.expiryDate,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(iconData, color: iconColor, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardNumber,
                  style: TextStyle(
                    color: const Color(0xFF2B2B2B),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  expiryDate,
                  style: TextStyle(
                    color: const Color(0xFF8E8E8E),
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          if (isDefault)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F4EA),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                'Default',
                style: TextStyle(
                  color: const Color(0xFF1E8E3E),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            )
          else
            Text(
              'Set Default',
              style: TextStyle(
                color: const Color(0xFF2D4373),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
        ],
      ),
    );
  }
}
