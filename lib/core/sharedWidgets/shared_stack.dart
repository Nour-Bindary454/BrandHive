import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/mixed_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedStack extends StatelessWidget {
  const SharedStack({
    super.key,
    required this.t1,
    required this.t2,
    required this.widget,
  });
  final String t1;
  final String t2;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MixedBg(
            lightColor: BasicColors.linearGradientSLight,
            darkColor: BasicColors.linearGradientSDark,
          ),
          Positioned(
            top: 80.h,
            left: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicText(
                  text: t1,
                  fontSize: 30.sp,
                  isBold: true,
                  color: Colors.white,
                ),
                BasicText(
                  text: t2,
                  fontSize: 30.sp,
                  isBold: true,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.h,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 0.h,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: widget,
            ),
          ),
        ],
      ),
    );
  }
}
