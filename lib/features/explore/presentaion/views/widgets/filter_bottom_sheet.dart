import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  final String initialSort;
  final String initialCategory;
  final String initialMinPrice;
  final String initialMaxPrice;
  final List<String> categories;

  const FilterBottomSheet({
    super.key,
    required this.initialSort,
    required this.initialCategory,
    required this.initialMinPrice,
    required this.initialMaxPrice,
    required this.categories,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String selectedSort;
  late String selectedCategory;
  String selectedShipping = 'All';

  static const Map<String, String> _categoryDisplayNames = {
    'handicrafts': 'Hand Crafts',
    'home-decor': 'Home Decor',
    'beauty': 'Beauty',
    'fashion': 'Fashion',
    'jewelry': 'Jewelry',
  };

  String _displayName(String apiName) {
    return _categoryDisplayNames[apiName.toLowerCase()] ?? apiName;
  }

  late final TextEditingController minPriceController;
  late final TextEditingController maxPriceController;

  @override
  void initState() {
    super.initState();
    selectedSort = widget.initialSort;
    selectedCategory = widget.initialCategory;
    minPriceController = TextEditingController(text: widget.initialMinPrice);
    maxPriceController = TextEditingController(text: widget.initialMaxPrice);
  }

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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      padding: EdgeInsets.fromLTRB(
        24.w,
        24.h,
        24.w,
        MediaQuery.of(context).padding.bottom + 16.h,
      ),
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
                _buildChip(
                  'Featured',
                  selectedSort,
                  (v) => setState(() => selectedSort = v),
                ),
                _buildChip(
                  'Price: Low',
                  selectedSort,
                  (v) => setState(() => selectedSort = v),
                ),
                _buildChip(
                  'Price: High',
                  selectedSort,
                  (v) => setState(() => selectedSort = v),
                ),
                _buildChip(
                  'Top Rated',
                  selectedSort,
                  (v) => setState(() => selectedSort = v),
                ),
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
                _buildChip(
                  'All',
                  selectedCategory,
                  (v) => setState(() => selectedCategory = v),
                ),
                ...widget.categories.map(
                  (cat) => _buildChip(
                    _displayName(cat),
                    _displayName(selectedCategory),
                    (v) => setState(
                      () => selectedCategory = widget.categories.firstWhere(
                        (c) => _displayName(c) == v,
                        orElse: () => v,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // PRICE RANGE
            _buildSectionTitle('PRICE RANGE'),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _buildPriceField('Min EGP', minPriceController),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildPriceField('Max EGP', maxPriceController),
                ),
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
                _buildChip(
                  'All',
                  selectedShipping,
                  (v) => setState(() => selectedShipping = v),
                ),
                _buildChip(
                  'Global Only',
                  selectedShipping,
                  (v) => setState(() => selectedShipping = v),
                ),
                _buildChip(
                  'Egypt Only',
                  selectedShipping,
                  (v) => setState(() => selectedShipping = v),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'sortBy': selectedSort,
                    'category': selectedCategory,
                    'minPrice': minPriceController.text,
                    'maxPrice': maxPriceController.text,
                  });
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
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

  Widget _buildChip(
    String label,
    String selectedValue,
    Function(String) onSelect,
  ) {
    bool isSelected = label == selectedValue;
    return GestureDetector(
      onTap: () => onSelect(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2D4373) : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2D4373)
                : const Color(0xFFE2E8F0),
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }
}
