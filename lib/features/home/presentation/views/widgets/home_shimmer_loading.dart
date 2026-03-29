import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeShimmerLoading extends StatefulWidget {
  const HomeShimmerLoading({Key? key}) : super(key: key);

  @override
  State<HomeShimmerLoading> createState() => _HomeShimmerLoadingState();
}

class _HomeShimmerLoadingState extends State<HomeShimmerLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSkeleton(double width, double height, {double borderRadius = 12}) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Skeleton
          Row(
            children: [
              _buildSkeleton(50, 50, borderRadius: 25),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _buildSkeleton(80, 14),
                   SizedBox(height: 8.h),
                   _buildSkeleton(120, 18),
                ],
              ),
              const Spacer(),
              _buildSkeleton(36, 36, borderRadius: 18),
            ],
          ),
          SizedBox(height: 24.h),
          // Search Skeleton
          _buildSkeleton(double.infinity, 56, borderRadius: 16),
          SizedBox(height: 24.h),
          // Hero Banner Skeleton
          _buildSkeleton(double.infinity, 200, borderRadius: 24),
          SizedBox(height: 24.h),
          // Action Buttons
          Row(
            children: [
              Expanded(child: _buildSkeleton(double.infinity, 48, borderRadius: 24)),
              SizedBox(width: 12.w),
              Expanded(child: _buildSkeleton(double.infinity, 48, borderRadius: 24)),
            ],
          ),
          SizedBox(height: 32.h),
          // Categories
          _buildSkeleton(100, 24),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
               children: List.generate(5, (index) => Padding(
                 padding: EdgeInsets.only(right: 16.w),
                 child: Column(
                   children: [
                     _buildSkeleton(70, 70, borderRadius: 16),
                     SizedBox(height: 8.h),
                     _buildSkeleton(50, 12),
                   ],
                 ),
               )),
            ),
          ),
          SizedBox(height: 32.h),
          // Events
          _buildSkeleton(120, 24),
          SizedBox(height: 16.h),
          _buildSkeleton(double.infinity, 100, borderRadius: 16),
          SizedBox(height: 32.h),
          
          // Promotional Banner
          _buildSkeleton(double.infinity, 100, borderRadius: 16),
          SizedBox(height: 32.h),

          // Top Local Brands
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkeleton(140, 24),
              _buildSkeleton(60, 16),
            ],
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
               children: List.generate(4, (index) => Padding(
                 padding: EdgeInsets.only(right: 16.w),
                 child: Column(
                   children: [
                     _buildSkeleton(120, 90, borderRadius: 16),
                     SizedBox(height: 8.h),
                     _buildSkeleton(80, 12),
                     SizedBox(height: 4.h),
                     _buildSkeleton(50, 10),
                   ],
                 ),
               )),
            ),
          ),
          SizedBox(height: 32.h),

          // Recommended for You
          Row(
            children: [
              _buildSkeleton(24, 24, borderRadius: 12),
              SizedBox(width: 8.w),
              _buildSkeleton(180, 24),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSkeleton(double.infinity, 300, borderRadius: 20),
          SizedBox(height: 32.h),

          // Featured Products
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkeleton(160, 24),
              _buildSkeleton(60, 16),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildSkeleton(double.infinity, 220, borderRadius: 20)),
              SizedBox(width: 16.w),
              Expanded(child: _buildSkeleton(double.infinity, 220, borderRadius: 20)),
            ],
          ),
        ],
      ),
    );
  }
}
