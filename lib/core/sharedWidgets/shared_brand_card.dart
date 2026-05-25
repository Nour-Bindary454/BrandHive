import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedBrandCard extends StatelessWidget {
  final BrandModel brand;
  final Widget? trailing;

  const SharedBrandCard({super.key, required this.brand, this.trailing});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/brandProfile', arguments: brand),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.04),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SharedBrandLogo(
                    logoUrl: brand.logoUrl,
                    initial: brand.name.isNotEmpty ? brand.name[0] : '',
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      brand.name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      brand.description,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              Positioned(top: 0, right: 0, child: trailing!),
          ],
        ),
      ),
    );
  }
}

class _SharedBrandLogo extends StatelessWidget {
  final String logoUrl;
  final String initial;

  const _SharedBrandLogo({required this.logoUrl, required this.initial});

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
                color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.05),
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
                    color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.1),
                    blurRadius: 4.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  initial.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
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
