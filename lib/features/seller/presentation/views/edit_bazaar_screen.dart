import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_cubit.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_states.dart';
import 'package:brand/features/seller/add/widgets/add_product_text_field.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBazaarScreen extends StatefulWidget {
  const EditBazaarScreen({super.key});

  @override
  State<EditBazaarScreen> createState() => _EditBazaarScreenState();
}

class _EditBazaarScreenState extends State<EditBazaarScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bazaar = context.read<BazaarCubit>().myBazaar;
    if (bazaar != null) {
      _nameController.text = bazaar.name;
      _descController.text = bazaar.description;
      _addressController.text = bazaar.address;
      _contactController.text = bazaar.contactInfo;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<BazaarCubit>().updateBazaar(
          name: _nameController.text.trim(),
          description: _descController.text.trim(),
          address: _addressController.text.trim(),
          contactInfo: _contactController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: const Color(0xFF0F172A), size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: BasicText(
          text: 'Edit Bazaar'.tr(),
          fontSize: 18.sp,
          color: const Color(0xFF0F172A),
          isBold: true,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<BazaarCubit, BazaarState>(
          listener: (context, state) {
            if (state is BazaarUpdateSuccess) {
              Toast.showSuccessToast(msg: state.message.tr(), context: context);
              Navigator.pop(context);
            } else if (state is BazaarUpdateFailure) {
              Toast.showErrorToast(msg: state.message.tr(), context: context);
            }
          },
          builder: (context, state) {
            final cubit = context.read<BazaarCubit>();
            final isLoading = state is BazaarUpdateLoading;

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    /// Image Section
                    SettingsCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BasicText(
                            text: 'Bazaar Image'.tr(),
                            fontSize: 14,
                            color: const Color(0xFF0F172A),
                            isBold: true,
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => cubit.pickBazaarImage(),
                                child: Container(
                                  width: 90.w,
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: cubit.pickedBazaarImage != null
                                          ? const Color(0xFF2D4373)
                                          : Colors.grey.shade300,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: cubit.pickedBazaarImage != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(10.r),
                                          child: Image.file(cubit.pickedBazaarImage!, fit: BoxFit.cover),
                                        )
                                      : cubit.myBazaar?.imageUrl != null && cubit.myBazaar!.imageUrl!.startsWith('http')
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10.r),
                                              child: Image.network(cubit.myBazaar!.imageUrl!, fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) => _buildAddPhotoIcon()),
                                            )
                                          : _buildAddPhotoIcon(),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BasicText(
                                      text: 'Tap to select photo'.tr(),
                                      fontSize: 12,
                                      color: const Color(0xFF0F172A),
                                      isBold: true,
                                    ),
                                    SizedBox(height: 4.h),
                                    BasicText(
                                      text: 'Recommended size: 800x800px'.tr(),
                                      fontSize: 10,
                                      color: Colors.grey.shade500,
                                    ),
                                    if (cubit.pickedBazaarImage != null) ...[
                                      SizedBox(height: 8.h),
                                      GestureDetector(
                                        onTap: () => cubit.clearPickedImage(),
                                        child: BasicText(
                                          text: 'Remove'.tr(),
                                          fontSize: 11,
                                          color: Colors.red,
                                          isBold: true,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// Form Fields Section
                    SettingsCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BasicText(
                            text: 'Bazaar Information'.tr(),
                            fontSize: 14,
                            color: const Color(0xFF0F172A),
                            isBold: true,
                          ),
                          SizedBox(height: 15.h),
                          AddProductTextField(
                            label: 'Bazaar Name *',
                            hintText: 'e.g. Grand Cairo Bazaar',
                            controller: _nameController,
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                          SizedBox(height: 12.h),
                          AddProductTextField(
                            label: 'Description *',
                            hintText: 'Describe your bazaar storefront...',
                            controller: _descController,
                            maxLines: 4,
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                          SizedBox(height: 12.h),
                          AddProductTextField(
                            label: 'Address / Location *',
                            hintText: 'e.g. Zamalek, Cairo',
                            controller: _addressController,
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                          SizedBox(height: 12.h),
                          AddProductTextField(
                            label: 'Contact Information *',
                            hintText: 'e.g. Phone number or WhatsApp link',
                            controller: _contactController,
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),

                    /// Submit Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: isLoading ? null : () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                side: const BorderSide(color: Color(0xFF2D4373), width: 1.2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                              ),
                              child: BasicText(
                                text: 'cancel'.tr(),
                                fontSize: 14,
                                color: const Color(0xFF2D4373),
                                isBold: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2D4373),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                                elevation: 0,
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                    )
                                  : BasicText(
                                      text: 'Save Details'.tr(),
                                      fontSize: 14,
                                      color: Colors.white,
                                      isBold: true,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddPhotoIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_photo_alternate_outlined, color: Colors.grey.shade500, size: 24.sp),
        SizedBox(height: 4.h),
        BasicText(text: 'add_photo'.tr(), fontSize: 10, color: Colors.grey.shade500),
      ],
    );
  }
}
