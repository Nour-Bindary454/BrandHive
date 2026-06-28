import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  
  const InfoRow({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
