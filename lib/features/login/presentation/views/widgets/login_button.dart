import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.image,
  });
  final String text;
  final VoidCallback onPressed;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.7,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color.fromARGB(255, 251, 251, 251)),
            borderRadius: BorderRadius.circular(7.6.r),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, fit: BoxFit.cover),
              SizedBox(width: 10.w),
              BasicText(
                text: text,
                fontSize: 13.sp,
                color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                isBold: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
