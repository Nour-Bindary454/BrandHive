import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryFilters extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const CategoryFilters({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: SizedBox(
        height: 36.h,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          separatorBuilder: (context, index) => SizedBox(width: 8.w),
          itemBuilder: (context, index) {
            final filter = filters[index];
            final isSelected = filter == selectedFilter;
            return GestureDetector(
              onTap: () => onFilterSelected(filter),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF2D4373) : const Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF5B5B5C),
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
