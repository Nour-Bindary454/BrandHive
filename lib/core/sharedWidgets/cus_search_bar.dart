import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CusSearchBar extends StatefulWidget {
  const CusSearchBar({super.key, required this.hintText});
  final String hintText;
  @override
  State<CusSearchBar> createState() => _CusSearchBarState();
}

class _CusSearchBarState extends State<CusSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 2.r,
            blurRadius: 10.r,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
          prefixIcon: Icon(Icons.search, color: Theme.of(context).textTheme.bodyMedium?.color),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
      ),
    );
  }
}
