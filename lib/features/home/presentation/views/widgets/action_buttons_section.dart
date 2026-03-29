import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButtonsSection extends StatelessWidget {
  final VoidCallback onShopNowTap;
  final VoidCallback onSellNowTap;

  const ActionButtonsSection({
    super.key,
    required this.onShopNowTap,
    required this.onSellNowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 105, 158, 237),
                  const Color.fromARGB(255, 18, 39, 67),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),

            child: ElevatedButton.icon(
              onPressed: onShopNowTap,
              icon: Icon(Icons.shopping_bag_outlined, size: 18.sp),
              label: Text(
                'Shop Now',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 4,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onSellNowTap,
            icon: Icon(Icons.storefront_outlined, size: 18.sp),
            label: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  const Color.fromARGB(255, 151, 183, 231),
                  const Color.fromARGB(255, 32, 63, 103),
                ],
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                'Sell Now',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF4A78B8),
              side: BorderSide(
                color: Color.fromARGB(255, 171, 194, 226),
                width: 1.5.w,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
          ),
        ),
      ],
    );
  }
}
