import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/sharedWidgets/basic_colors.dart';
import '../../../../../core/sharedWidgets/basic_text.dart';

class BazaarSectionTitle extends StatelessWidget {
  final String title;

  const BazaarSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 12.h, left: 4.w),
      child: BasicText(
        text: title,
        fontSize: 18.sp,
        color: BasicColors.black,
        isBold: true,
      ),
    );
  }
}
