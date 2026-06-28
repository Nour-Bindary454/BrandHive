import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TappableRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  
  const TappableRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18.sp, color: Colors.grey[500]),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey[500])),
                  SizedBox(height: 2.h),
                  Text(value,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF2D4373),
                          decoration: TextDecoration.underline)),
                ],
              ),
            ),
            Icon(Icons.open_in_new, size: 14.sp, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
