import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersFilter extends StatefulWidget {
  const OrdersFilter({super.key});

  @override
  State<OrdersFilter> createState() => _OrdersFilterState();
}

class _OrdersFilterState extends State<OrdersFilter> {
  final List<String> filters = ['All', 'Pending', 'Processing', 'Completed'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: List.generate(filters.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2D4373) : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? const Color(0xFF2D4373) : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: BasicText(
                text: filters[index],
                fontSize: 12,
                color: isSelected ? Colors.white : const Color(0xFF475467),
                isBold: true,
              ),
            ),
          );
        }),
      ),
    );
  }
}
