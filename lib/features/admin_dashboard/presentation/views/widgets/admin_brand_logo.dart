import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminBrandLogo extends StatelessWidget {
  final String logoUrl;
  final String initial;
  const AdminBrandLogo({super.key, required this.logoUrl, required this.initial});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80.r,
          height: 80.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black)
                    .withOpacity(0.05),
                blurRadius: 8.r,
                offset: const Offset(0, 2),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(logoUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -5.h,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black)
                        .withOpacity(0.1),
                    blurRadius: 4.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  initial.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
