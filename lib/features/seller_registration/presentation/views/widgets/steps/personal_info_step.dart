import 'package:easy_localization/easy_localization.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/registration_text_field.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/section_header.dart';
import 'package:flutter/material.dart';

class PersonalInfoStep extends StatelessWidget {
  const PersonalInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          stepNumber: '01',
          title: 'personal_information'.tr().tr(),
          icon: Icons.person_outline,
        ),
        const RegistrationTextField(
          hint: 'Full name',
          prefixIcon: Icons.person_outline,
        ),
        const RegistrationTextField(
          hint: 'Email address',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const RegistrationTextField(
          hint: 'Phone number',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const RegistrationTextField(
          hint: 'Password',
          prefixIcon: Icons.lock_outline,
          isPassword: true,
        ),
        const RegistrationTextField(
          hint: 'Confirm password',
          prefixIcon: Icons.verified_user_outlined,
          isPassword: true,
        ),
      ],
    );
  }
}
