import 'package:brand/features/seller_registration/data/model/category_model.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/registration_text_field.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/section_header.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/steps/brand_logo.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/store_category_selector.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/store_ships_toggle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreInfoStep extends StatefulWidget {
  final TextEditingController? nameController;
  final TextEditingController? descriptionController;
  final TextEditingController? websiteController;
  final TextEditingController? whatsappController;
  final List<CategoryModel> categories;
  final List<String> selectedCategoryIds;
  final ValueChanged<List<String>>? onCategoriesChanged;
  final bool shipsInternationally;
  final ValueChanged<bool>? onShipsInternationallyChanged;
  final File? selectedLogo;
  final ValueChanged<File> onLogoSelected;

  const StoreInfoStep({
    super.key,
    required this.selectedLogo,
    required this.onLogoSelected,
    this.nameController,
    this.descriptionController,
    this.websiteController,
    this.whatsappController,
    required this.categories,
    required this.selectedCategoryIds,
    this.onCategoriesChanged,
    required this.shipsInternationally,
    this.onShipsInternationallyChanged,
  });

  @override
  State<StoreInfoStep> createState() => _StoreInfoStepState();
}

class _StoreInfoStepState extends State<StoreInfoStep> {
  late TextEditingController _descriptionController;
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        widget.descriptionController ?? TextEditingController();
    _charCount = _descriptionController.text.length;
    _descriptionController.addListener(
      () => setState(() => _charCount = _descriptionController.text.length),
    );
  }

  @override
  void dispose() {
    if (widget.descriptionController == null) {
      _descriptionController.dispose();
    }
    super.dispose();
  }

  void _toggleCategory(String id) {
    final updated = List<String>.from(widget.selectedCategoryIds);
    updated.contains(id) ? updated.remove(id) : updated.add(id);
    widget.onCategoriesChanged?.call(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          stepNumber: '02',
          title: 'store_information'.tr(),
          icon: Icons.storefront_outlined,
        ),
        SizedBox(height: 16.h),
        BrandLogoPicker(
          initialImage: widget.selectedLogo,
          onImageSelected: widget.onLogoSelected,
        ),
        SizedBox(height: 16.h),

        RegistrationTextField(
          hint: 'Store name',
          prefixIcon: Icons.store_outlined,
          controller: widget.nameController,
        ),

        StoreCategorySelector(
          categories: widget.categories,
          selectedCategoryIds: widget.selectedCategoryIds,
          onToggle: _toggleCategory,
        ),

        Stack(
          children: [
            RegistrationTextField(
              hint: 'DESCRIPTION\n\nTell buyers about your store',
              maxLines: 5,
              controller: _descriptionController,
            ),
            Positioned(
              bottom: 24,
              right: 16,
              child: Text(
                '$_charCount / 240',
                style: const TextStyle(
                  color: Color(0xFF8E8E8E),
                  fontSize: 10,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),

        RegistrationTextField(
          hint: 'Website (optional)',
          prefixIcon: Icons.link_outlined,
          controller: widget.websiteController,
          keyboardType: TextInputType.url,
        ),

        RegistrationTextField(
          hint: 'WhatsApp link (optional)',
          prefixIcon: Icons.chat_outlined,
          controller: widget.whatsappController,
          keyboardType: TextInputType.url,
        ),

        StoreShipsToggle(
          value: widget.shipsInternationally,
          onChanged: widget.onShipsInternationallyChanged,
        ),

        SizedBox(height: 16.h),
      ],
    );
  }
}
