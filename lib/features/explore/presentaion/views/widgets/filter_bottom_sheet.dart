import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedSort = 'Featured';
  String selectedCategory = 'All';
  String selectedShipping = 'All';
  
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, MediaQuery.of(context).viewInsets.bottom + 24.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter & Sort',
                  style: TextStyle(
                    color: const Color(0xFF2D4373),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F4F7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: const Color(0xFF5B5B5C),
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // SORT BY
            _buildSectionTitle('SORT BY'),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 12.h,
              children: [
                _buildChip('Featured', selectedSort, (v) => setState(() => selectedSort = v)),
                _buildChip('Price: Low', selectedSort, (v) => setState(() => selectedSort = v)),
                _buildChip('Price: High', selectedSort, (v) => setState(() => selectedSort = v)),
                _buildChip('Top Rated', selectedSort, (v) => setState(() => selectedSort = v)),
              ],
            ),
            SizedBox(height: 24.h),

            // CATEGORY
            _buildSectionTitle('CATEGORY'),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 12.h,
              children: [
                _buildChip('All', selectedCategory, (v) => setState(() => selectedCategory = v)),
                _buildChip('Fashion', selectedCategory, (v) => setState(() => selectedCategory = v)),
                _buildChip('Jewelry', selectedCategory, (v) => setState(() => selectedCategory = v)),
                _buildChip('Ceramics', selectedCategory, (v) => setState(() => selectedCategory = v)),
                _buildChip('Beauty', selectedCategory, (v) => setState(() => selectedCategory = v)),
                _buildChip('Food', selectedCategory, (v) => setState(() => selectedCategory = v)),
                _buildChip('Home Decor', selectedCategory, (v) => setState(() => selectedCategory = v)),
              ],
            ),
            SizedBox(height: 24.h),

            // PRICE RANGE
            _buildSectionTitle('PRICE RANGE'),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(child: _buildPriceField('Min EGP', minPriceController)),
                SizedBox(width: 16.w),
                Expanded(child: _buildPriceField('Max EGP', maxPriceController)),
              ],
            ),
            SizedBox(height: 24.h),

            // SHIPS INTERNATIONALLY
            _buildSectionTitle('SHIPS INTERNATIONALLY'),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 12.h,
              children: [
                _buildChip('All', selectedShipping, (v) => setState(() => selectedShipping = v)),
                _buildChip('Global Only', selectedShipping, (v) => setState(() => selectedShipping = v)),
                _buildChip('Egypt Only', selectedShipping, (v) => setState(() => selectedShipping = v)),
              ],
            ),
            SizedBox(height: 32.h),

            // Apply Button
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () {
                  // Apply filter logic here
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D4373),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Apply Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFF4A5568),
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildChip(String label, String selectedValue, Function(String) onSelect) {
    bool isSelected = label == selectedValue;
    return GestureDetector(
      onTap: () => onSelect(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2D4373) : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF2D4373) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF4A5568),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildPriceField(String hint, TextEditingController controller) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: const Color(0xFF2B2B2B),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: const Color(0xFFA0AEC0),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }
}
