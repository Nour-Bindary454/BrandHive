import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/sharedWidgets/basic_colors.dart';

class BazaarHeroHeader extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onBackTap;

  const BazaarHeroHeader({
    super.key,
    required this.imageUrl,
    required this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full width background image
        Image.network(
          imageUrl,
          width: double.infinity,
          height: 250.h,
          fit: BoxFit.cover,
        ),
        // Overlay Gradient for readability
        Container(
          width: double.infinity,
          height: 250.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [BasicColors.black.withOpacity(0.5), Colors.transparent],
            ),
          ),
        ),
        // Back Button
        Positioned(
          top: 40.h, // Safe area approximation
          left: 16.w,
          child: GestureDetector(
            onTap: onBackTap,
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: BasicColors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: BasicColors.white,
                size: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
