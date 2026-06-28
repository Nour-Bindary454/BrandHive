import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/home/presentation/views/widgets/brand_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllBrandsScreen extends StatelessWidget {
  final List<BrandModel> brands;

  const AllBrandsScreen({super.key, required this.brands});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'All Brands',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 16.h, bottom: 32.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.85,
            ),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              return BrandGridItem(brand: brands[index]);
            },
          ),
        ),
      ),
    );
  }
}
