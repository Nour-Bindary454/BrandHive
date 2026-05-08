import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategContainer extends StatelessWidget {
  CategContainer({
    super.key,
    required this.image,
    required this.title,
    required this.discription,
    required this.tap,
  });
  final String image;
  final String title;
  final String discription;
  final void Function()? tap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.only(bottom: 10, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BasicText(
              text: title,
              fontSize: 14,
              color: BasicColors.white,
              isBold: true,
            ),
            BasicText(
              text: discription,
              fontSize: 10,
              color: BasicColors.white,
              isBold: false,
            ),
          ],
        ),
      ),
    );
  }
}
