import 'package:brand/features/seller_registration/presentation/views/widgets/registration_dropdown.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/registration_text_field.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/section_header.dart';
import 'package:flutter/material.dart';

class AddressInfoStep extends StatefulWidget {
  const AddressInfoStep({super.key});

  @override
  State<AddressInfoStep> createState() => _AddressInfoStepState();
}

class _AddressInfoStepState extends State<AddressInfoStep> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          stepNumber: '03',
          title: 'Address Information',
          icon: Icons.location_on_outlined,
        ),
        RegistrationDropdown(
          hint: 'Select Country',
          prefixIcon: Icons.language_outlined,
          items: const ['Egypt', 'Saudi Arabia', 'UAE', 'USA', 'UK'],
          value: selectedCountry,
          onChanged: (value) {
            setState(() {
              selectedCountry = value;
            });
          },
        ),
        const RegistrationTextField(
          hint: 'City',
          prefixIcon: Icons.location_city_outlined,
        ),
        const RegistrationTextField(
          hint: 'Street Address',
          prefixIcon: Icons.home_outlined,
        ),
      ],
    );
  }
}
