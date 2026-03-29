import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RatingWidget extends StatelessWidget {
  final double rating;
  final int? reviewCount;
  final Color starColor;
  final TextStyle? textStyle;

  const RatingWidget({
    super.key,
    required this.rating,
    this.reviewCount,
    this.starColor = const Color(0xFFFFC107), // Amber
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, size: 16.sp, color: starColor),
        SizedBox(width: 4.w),
        Text(
          rating.toString(),
          style: textStyle ?? TextStyle(fontWeight: FontWeight.bold),
        ),
        if (reviewCount != null) ...[
          SizedBox(width: 4.w),
          Text(
            '($reviewCount reviews)',
            style: textStyle?.copyWith(color: Colors.grey) ?? 
                TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
        ],
      ],
    );
  }
}

class FollowButton extends StatelessWidget {
  final bool isFollowed;
  final VoidCallback onPressed;

  const FollowButton({
    super.key,
    required this.isFollowed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowed ? Colors.white : const Color(0xFF1A1A1A),
          foregroundColor: isFollowed ? const Color(0xFF1A1A1A) : Colors.white,
          elevation: 0,
          side: isFollowed ? const BorderSide(color: Color(0xFFE0E0E0)) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
        ),
        child: Text(
          isFollowed ? 'Following' : 'Follow',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
        ),
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddToCartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1A237E), // Deep Blue
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Icon(Icons.add, color: Colors.white, size: 20.sp),
        ),
      ),
    );
  }
}
