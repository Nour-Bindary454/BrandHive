import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackarrow extends StatelessWidget {
  const CustomBackarrow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}
