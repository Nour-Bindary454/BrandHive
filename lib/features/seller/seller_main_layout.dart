import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/utils/appImages/png_images.dart';

import 'package:brand/features/cart/cart.dart';
import 'package:brand/features/explore/explore.dart';
import 'package:brand/features/home/presentation/views/home.dart';
import 'package:brand/features/main_layout/presentation/view_model/nav_cubit.dart';
import 'package:brand/features/profile/presentation/views/profile_screen.dart';
import 'package:brand/features/seller/add/add.dart';
import 'package:brand/features/seller/orders/orders.dart';
import 'package:brand/features/seller/overView/overview.dart';
import 'package:brand/features/seller/products/products.dart';
import 'package:brand/features/seller/settings/settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SellerMainLayout extends StatelessWidget {
  SellerMainLayout({super.key});

  final List<Widget> screens = [
    Overview(),
    Products(),
    Add(),
    Orders(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            extendBody:
                true, // Allows body content to scroll behind the nav bar if needed
            body: screens[currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, -5), // Shadow going up slightly
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  height: 70.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // The row of icons
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                        ), // Preserving the previous 20w outer + 10w inner spacing
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNavItem(
                              context,
                              0,
                              currentIndex,
                              PngImages.overview,
                              'Overview',
                            ),
                            _buildNavItem(
                              context,
                              1,
                              currentIndex,
                              PngImages.products,
                              'Products',
                            ),

                            // Placeholder for Add button space
                            SizedBox(width: 60.w),

                            _buildNavItem(
                              context,
                              3,
                              currentIndex,
                              PngImages.orders,
                              'Orders',
                            ),
                            _buildNavItem(
                              context,
                              4,
                              currentIndex,
                              PngImages.setting,
                              'Settings',
                            ),
                          ],
                        ),
                      ),

                      // The Add button popping up
                      Positioned(
                        top: -15.h, // Pops out of the bar
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            context.read<LayoutCubit>().changeIndex(2);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 55.r,
                                height: 55.r,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2D4373), // Dark blue
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    PngImages.add,
                                    color: Colors.white,
                                    width: 20.r,
                                    height: 20.r,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: currentIndex == 2
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: currentIndex == 2
                                      ? BasicColors.linearGradientDark
                                      : BasicColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    int currentIndex,
    String iconPath,
    String label,
  ) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () {
        context.read<LayoutCubit>().changeIndex(index);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 55.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(iconPath),
              size: 24.sp,
              color: isSelected
                  ? BasicColors.linearGradientDark
                  : BasicColors.grey,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? BasicColors.linearGradientDark
                    : BasicColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
