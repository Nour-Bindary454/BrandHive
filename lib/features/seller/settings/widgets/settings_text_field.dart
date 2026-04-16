import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final int maxLines;

  const SettingsTextField({
    super.key,
    required this.label,
    required this.initialValue,
    this.maxLines = 1,
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
          initialValue: initialValue,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade700,
            fontFamily: 'Poppins',
          ),
          decoration: InputDecoration(
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
