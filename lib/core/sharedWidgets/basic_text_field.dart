import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicTextField extends StatefulWidget {
  const BasicTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.isPassword,
  });
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF5B5B5C), // لون رمادي هادي زي الصورة
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 44.h,

          child: TextField(
            obscureText: widget.isPassword,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              // شكل الحدود وهي مش متداس عليها
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r), // الحواف الدائرية
                borderSide: const BorderSide(
                  color: Color(0xFFD1D1D1),
                ), // لون الحدود الرمادي
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Color(0xFFD1D1D1), width: 2.w),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
