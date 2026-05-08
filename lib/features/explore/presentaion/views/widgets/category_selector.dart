import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<String> categories = [
    'All',
    'Fashion',
    'Home',
    'Accessories',
    'Beauty',
    'HandCrafts',
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10), // مسافة بين الزراير
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // لو هو المختار بياخد اللون الكحلي، لو لأ بياخد أبيض
                color: selectedIndex == index
                    ? Color(0xFF2D4373)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20), // الحواف الدائرية
                //  border: Border.all(color: Colors.grey.shade300), // إطار خفيف
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // لون الكلام يتغير حسب الاختيار
                  color: selectedIndex == index ? Colors.white : Colors.black54,
                ),
              ),
            ),
          );
        },
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
