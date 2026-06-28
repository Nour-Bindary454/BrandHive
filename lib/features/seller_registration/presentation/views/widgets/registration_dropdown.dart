import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationDropdown extends StatelessWidget {
  final String hint;
  final IconData? prefixIcon;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;

  const RegistrationDropdown({
    super.key,
    required this.hint,
    this.prefixIcon,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: DropdownButtonFormField<String>(
        value: value,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: const Color(0xFF2B2B2B),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: const Color(0xFF8E8E8E),
          size: 24.sp,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: const Color(0xFF8E8E8E),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: const Color(0xFF8E8E8E),
                  size: 20.sp,
                )
              : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: Color(0xFFE5E5E5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: const Color(0xFF2D4373),
              width: 1.5.w,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                color: const Color(0xFF2B2B2B),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
