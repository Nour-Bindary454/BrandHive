import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/features/resetPassword/view/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyButtonSection extends StatelessWidget {
  const VerifyButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Verify Button
        Center(
          child: BasicButton(
            text: 'Verify',
            colors: const [Color(0xFF2D4373)],
            radius: 12.r,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResetPassword()),
              );
            },
          ),
        ),

        SizedBox(height: 25.h),

        // Send code again
        Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              children: const [
                TextSpan(text: 'Send code again  '),
                TextSpan(
                  text: '00:20',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
