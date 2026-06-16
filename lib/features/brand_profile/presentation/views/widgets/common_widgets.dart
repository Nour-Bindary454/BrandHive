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
    this.starColor = const Color(0xFFFFC107),
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
            style: textStyle?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)) ?? 
                TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontSize: 12.sp),
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
      height: 40.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowed ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.primary,
          foregroundColor: isFollowed ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
          elevation: 0,
          side: isFollowed ? BorderSide(color: Theme.of(context).dividerColor) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            isFollowed ? 'Following' : 'Follow',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
          ),
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
      color: Theme.of(context).colorScheme.primary,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary, size: 20.sp),
        ),
      ),
    );
  }
}
