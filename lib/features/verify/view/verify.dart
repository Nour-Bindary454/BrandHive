import 'package:brand/features/verify/view/widgets/custom_keyboard.dart';
import 'package:brand/features/verify/view/widgets/otp_inputs.dart';
import 'package:brand/features/verify/view/widgets/verify_button_section.dart';
import 'package:brand/features/verify/view/widgets/verify_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  String otpCode = '';

  void _onKeypadPressed(String value) {
    if (value == 'backspace') {
      if (otpCode.isNotEmpty) {
        setState(() {
          otpCode = otpCode.substring(0, otpCode.length - 1);
        });
      }
    } else {
      if (otpCode.length < 4) {
        setState(() {
          otpCode += value;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false, // We handle bottom safe area in CustomKeyboard
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    const VerifyHeader(),
                    SizedBox(height: 40.h),
                    OtpInputs(otpCode: otpCode),
                    SizedBox(height: 40.h),
                    const VerifyButtonSection(),
                  ],
                ),
              ),
            ),
            
            // Custom Keyboard
            CustomKeyboard(onKeypadPressed: _onKeypadPressed),
          ],
        ),
      ),
    );
  }
}
