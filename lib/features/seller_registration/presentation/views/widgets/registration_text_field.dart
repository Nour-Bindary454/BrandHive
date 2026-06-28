import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationTextField extends StatefulWidget {
  final String hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnly; // ← جديد
  final int maxLines;
  final TextInputType keyboardType;

  const RegistrationTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.isPassword = false,
    this.readOnly = false, // ← جديد
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<RegistrationTextField> createState() => _RegistrationTextFieldState();
}

class _RegistrationTextFieldState extends State<RegistrationTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly, // ← جديد
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: widget.readOnly
              ? const Color(0xFF8E8E8E) // لون أفتح لو read-only
              : const Color(0xFF2B2B2B),
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: const Color(0xFF8E8E8E),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: const Color(0xFF8E8E8E),
                  size: 20.sp,
                )
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF8E8E8E),
                    size: 20.sp,
                  ),
                  onPressed: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                )
              : widget.suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: widget.maxLines > 1 ? 16.h : 12.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: widget.readOnly
                  ? const Color(0xFFEEEEEE) // border أفتح لو read-only
                  : const Color(0xFFE5E5E5),
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
          fillColor: widget.readOnly
              ? const Color(0xFFF5F5F5) // background أفتح لو read-only
              : Colors.white,
        ),
      ),
    );
  }
}
