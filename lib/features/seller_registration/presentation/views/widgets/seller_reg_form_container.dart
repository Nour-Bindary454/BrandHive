import 'dart:io';

import 'package:brand/features/seller_registration/data/model/category_model.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/seller_bottom_navigation.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/steps/address_info_step.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/steps/personal_info_step.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/steps/store_info_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerRegFormContainer extends StatelessWidget {
  final PageController pageController;
  final List<CategoryModel> categories;

  // Store Info
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController websiteController;
  final TextEditingController whatsappController;

  final List<String> selectedCategoryIds;
  final ValueChanged<List<String>> onCategoriesChanged;

  final bool shipsInternationally;
  final ValueChanged<bool> onShipsInternationallyChanged;

  // Logo
  final File? selectedLogo;
  final ValueChanged<File> onLogoSelected;

  // Address Info
  final String? selectedCountry;
  final ValueChanged<String?> onCountryChanged;
  final TextEditingController cityController;
  final TextEditingController phoneController;

  // Navigation
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const SellerRegFormContainer({
    super.key,
    required this.pageController,
    required this.categories,

    required this.nameController,
    required this.descriptionController,
    required this.websiteController,
    required this.whatsappController,

    required this.selectedCategoryIds,
    required this.onCategoriesChanged,

    required this.shipsInternationally,
    required this.onShipsInternationallyChanged,

    required this.selectedLogo,
    required this.onLogoSelected,

    this.selectedCountry,
    required this.onCountryChanged,
    required this.cityController,
    required this.phoneController,

    required this.onBack,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
        boxShadow: [
          BoxShadow(
            color:
                (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black)
                    .withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Step 1 - Personal Info
                SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      PersonalInfoStep(phoneController: phoneController),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),

                // Step 2 - Store Info + Logo
                SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      StoreInfoStep(
                        nameController: nameController,
                        descriptionController: descriptionController,
                        websiteController: websiteController,
                        whatsappController: whatsappController,
                        categories: categories,
                        selectedCategoryIds: selectedCategoryIds,
                        onCategoriesChanged: onCategoriesChanged,
                        shipsInternationally: shipsInternationally,
                        onShipsInternationallyChanged:
                            onShipsInternationallyChanged,
                        selectedLogo: selectedLogo,
                        onLogoSelected: onLogoSelected,
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),

                // Step 3 - Address
                SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      AddressInfoStep(
                        selectedCountry: selectedCountry,
                        onCountryChanged: onCountryChanged,
                        cityController: cityController,
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Navigation
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
            child: SellerBottomNavigation(
              onBack: onBack,
              onContinue: onContinue,
            ),
          ),
        ],
      ),
    );
  }
}
