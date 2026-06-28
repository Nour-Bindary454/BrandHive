import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShippingForm extends StatelessWidget {
  const CustomShippingForm({
    super.key,
    required this.context,
    required this.label,
    required this.controller,
    required this.isPhone,
    this.onChanged,
  });

  final BuildContext context;
  final String label;
  final TextEditingController controller;
  final bool isPhone;
  final ValueChanged<String>? onChanged;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicText(
          text: label,
          fontSize: 12.sp,
          color: Color.fromARGB(255, 15, 23, 41),
          isBold: false,
        ),

        SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
            validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,

            decoration: InputDecoration(
              isDense: true,

              contentPadding: EdgeInsets.symmetric(
                vertical: 6.h,
                horizontal: 8.w,
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 252, 252, 252),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: (BasicColors.buttonColorDark)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
