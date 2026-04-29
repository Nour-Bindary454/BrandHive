import 'package:brand/features/seller_registration/presentation/views/widgets/registration_dropdown.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/registration_text_field.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/section_header.dart';
import 'package:flutter/material.dart';

class StoreInfoStep extends StatefulWidget {
  const StoreInfoStep({super.key});

  @override
  State<StoreInfoStep> createState() => _StoreInfoStepState();
}

class _StoreInfoStepState extends State<StoreInfoStep> {
  String? selectedCategory;
  String? selectedBusinessType;
  final TextEditingController _descriptionController = TextEditingController();
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(() {
      setState(() {
        _charCount = _descriptionController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          stepNumber: '02',
          title: 'Store Information',
          icon: Icons.store_outlined,
        ),
        const RegistrationTextField(
          hint: 'Store name',
          prefixIcon: Icons.store_outlined,
        ),
        RegistrationDropdown(
          hint: 'Select a category',
          prefixIcon: Icons.local_offer_outlined,
          items: const ['Fashion', 'Electronics', 'Home', 'Beauty', 'Other'],
          value: selectedCategory,
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          },
        ),
        RegistrationDropdown(
          hint: 'Business type',
          prefixIcon: Icons.business_center_outlined,
          items: const ['Individual', 'Company', 'LLC'],
          value: selectedBusinessType,
          onChanged: (value) {
            setState(() {
              selectedBusinessType = value;
            });
          },
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
      ],
    );
  }
}
