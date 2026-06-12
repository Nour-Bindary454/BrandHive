import 'package:brand/features/seller_registration/data/model/category_model.dart';
import 'package:brand/features/seller_registration/presentation/viewModel/seller_reg_cubit.dart';
import 'package:brand/features/seller_registration/presentation/viewModel/seller_reg_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreCategorySelector extends StatelessWidget {
  final List<CategoryModel> categories;
  final List<String> selectedCategoryIds;
  final ValueChanged<String> onToggle;

  const StoreCategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategoryIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            'Categories',
            style: TextStyle(
              color: const Color(0xFF2B2B2B),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        BlocBuilder<BrandRequestCubit, BrandRequestState>(
          builder: (context, state) {
            final cubit = context.read<BrandRequestCubit>();
            final cats = cubit.categories;

            if (state is CategoriesLoading || (state is BrandRequestInitial && cats.isEmpty)) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Center(
                  child: SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF2D4373),
                    ),
                  ),
                ),
              );
            }

            if (state is CategoriesFailure) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Center(
                  child: Text(
                    'Failed to load categories: ${state.error}',
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
              );
            }

            if (cats.isEmpty) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Center(
                  child: Text(
                    'No categories available',
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: cats.map((cat) {
                  final isSelected = selectedCategoryIds.contains(cat.id);
                  return GestureDetector(
                    onTap: () => onToggle(cat.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF2D4373)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF2D4373)
                              : const Color(0xFFE5E5E5),
                        ),
                      ),
                      child: Text(
                        cat.name,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF2B2B2B),
                          fontSize: 12.sp,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
