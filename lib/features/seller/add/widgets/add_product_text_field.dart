import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const AddProductTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: BasicText(
            text: label,
            fontSize: 11,
            color: const Color(0xFF1F2937),
            isBold: true,
          ),
        ),
        TextFormField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF0F172A),
            fontFamily: 'Poppins',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade400,
            ),
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF1B354D)),
            ),
          ),
        ),
      ],
    );
  }
}
