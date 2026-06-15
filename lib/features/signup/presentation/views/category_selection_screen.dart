import 'dart:convert';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/shared_stack.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/core/services/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final List<String> availableCategories = [
    'Accessories',
    'Beauty',
    'Fashion',
    'Home Decor',
    'Handicrafts',
  ];
  final List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String? ?? '';

    return PopScope(
      canPop: false,
      child: SharedStack(
        t1: 'Personalize Your',
        t2: 'Shopping Feed',
        widget: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Select the categories you are interested in so we can tailor the best recommendations for you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    alignment: WrapAlignment.center,
                    children: availableCategories.map((category) {
                      final isSelected = selectedCategories.contains(category);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedCategories.remove(category);
                            } else {
                              selectedCategories.add(category);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [
                                      BasicColors.linearGradientSLight,
                                      BasicColors.linearGradientSDark,
                                    ],
                                  )
                                : null,
                            color: isSelected ? null : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : Theme.of(context).dividerColor,
                              width: 1.5,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: BasicColors.linearGradientSLight.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    )
                                  ]
                                : null,
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14.sp,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 40.h),
                BasicButton(
                  onPressed: () async {
                    if (selectedCategories.isEmpty) {
                      Toast.showErrorToast(
                        msg: "Please select at least one interest",
                        context: context,
                      );
                      return;
                    }
  
                    // Save choices to local cache
                    await CacheHelper.saveData(
                      key: 'pref_categories',
                      value: jsonEncode(selectedCategories),
                    );
  
                    // Proceed to verification
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/verify',
                        arguments: email,
                      );
                    }
                  },
                  text: "Continue",
                  colors: [
                    BasicColors.linearGradientSLight,
                    BasicColors.linearGradientSDark,
                  ],
                  radius: 7.65,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
