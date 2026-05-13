import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/registration_text_field.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/section_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoStep extends StatefulWidget {
  final TextEditingController? phoneController;

  const PersonalInfoStep({super.key, this.phoneController});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = CacheHelper.getData(key: 'name') ?? '';
    _emailController.text = CacheHelper.getData(key: 'email') ?? '';
    if (widget.phoneController != null &&
        widget.phoneController!.text.isEmpty) {
      widget.phoneController!.text = CacheHelper.getData(key: 'phone') ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          stepNumber: '01',
          title: 'personal_information'.tr(),
          icon: Icons.person_outline,
        ),

        // Name - read only
        RegistrationTextField(
          hint: 'Full name',
          prefixIcon: Icons.person_outline,
          controller: _nameController,
          readOnly: true,
        ),

        // Email - read only
        RegistrationTextField(
          hint: 'Email address',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          readOnly: true,
        ),

        // Phone
        RegistrationTextField(
          hint: 'Phone number',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          controller: widget.phoneController,
        ),

        // Info message
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF2D4373).withOpacity(0.07),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D4373).withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF2D4373),
                size: 18.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Your account information will be used for verification.',
                  style: TextStyle(
                    color: const Color(0xFF2D4373),
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
