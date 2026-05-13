import 'package:brand/features/seller_registration/presentation/views/widgets/registration_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/registration_dropdown.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/section_header.dart';
import 'package:flutter/material.dart';

class AddressInfoStep extends StatelessWidget {
  final String? selectedCountry;
  final ValueChanged<String?>? onCountryChanged;
  final TextEditingController? cityController;

  const AddressInfoStep({
    super.key,
    this.selectedCountry,
    this.onCountryChanged,
    this.cityController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          stepNumber: '03',
          title: 'address_information'.tr(),
          icon: Icons.location_on_outlined,
        ),

        RegistrationDropdown(
          hint: 'Select Country',
          prefixIcon: Icons.language_outlined,
          items: const [
            'Egypt',
            'Saudi Arabia',
            'UAE',
            'Kuwait',
            'Qatar',
            'Bahrain',
            'Jordan',
            'USA',
            'UK',
          ],
          value: selectedCountry,
          onChanged: (value) => onCountryChanged?.call(value),
        ),

        RegistrationTextField(
          hint: 'City',
          prefixIcon: Icons.location_city_outlined,
          controller: cityController,
        ),
      ],
    );
  }
}
