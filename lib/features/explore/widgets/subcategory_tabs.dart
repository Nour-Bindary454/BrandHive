import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/sharedWidgets/basic_colors.dart';

class SubcategoryTabs extends StatefulWidget {
  const SubcategoryTabs({super.key});

  @override
  State<SubcategoryTabs> createState() => _SubcategoryTabsState();
}

class _SubcategoryTabsState extends State<SubcategoryTabs> {
  List<String> subcategories = [
    'All',
    'Women',
    'Men',
    'Kids',
    'Home',
    'Others',
  ];
  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? BasicColors.buttonColorLight
                    : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: selectedIndex == index
                    ? null
                    : Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                subcategories[index],
                style: TextStyle(
                  fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                  color: selectedIndex == index ? Colors.white : Colors.black87,
                ),
              ),
            ),
          );
        },
        itemCount: subcategories.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
