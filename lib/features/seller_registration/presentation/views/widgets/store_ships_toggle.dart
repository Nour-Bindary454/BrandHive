import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreShipsToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const StoreShipsToggle({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.flight_outlined,
            color: const Color(0xFF8E8E8E),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ships Internationally',
                  style: TextStyle(
                    color: const Color(0xFF2B2B2B),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Do you ship outside your country?',
                  style: TextStyle(
                    color: const Color(0xFF8E8E8E),
                    fontSize: 11.sp,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF2D4373),
          ),
        ],
      ),
    );
  }
}
