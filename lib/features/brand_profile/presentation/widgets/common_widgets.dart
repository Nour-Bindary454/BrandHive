import 'package:flutter/material.dart';

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
        Icon(Icons.star, size: 16, color: starColor),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: textStyle ?? const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (reviewCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount reviews)',
            style: textStyle?.copyWith(color: Colors.grey) ?? 
                const TextStyle(color: Colors.grey, fontSize: 12),
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
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowed ? Colors.white : const Color(0xFF1A1A1A),
          foregroundColor: isFollowed ? const Color(0xFF1A1A1A) : Colors.white,
          elevation: 0,
          side: isFollowed ? const BorderSide(color: Color(0xFFE0E0E0)) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Text(
          isFollowed ? 'Following' : 'Follow',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
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
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.add, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
