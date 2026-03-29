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
      height: 44.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: const Color.fromARGB(255, 251, 251, 251)),
            borderRadius: BorderRadius.circular(7.6.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            SizedBox(width: 10.w),
            BasicText(
              text: text,
              fontSize: 13.sp,
              color: Colors.black,
              isBold: false,
            ),
          ],
        ),
      ),
    );
  }
}
