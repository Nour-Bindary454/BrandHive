import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import '../../data/models/address_model.dart';
import '../viewmodels/address_cubit.dart';
import '../viewmodels/address_state.dart';

class AddEditAddressScreen extends StatefulWidget {
  final AddressModel? address;

  const AddEditAddressScreen({super.key, this.address});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _governorateController;
  late TextEditingController _countryController;
  late TextEditingController _labelController;

  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(
      text: widget.address?.fullName ?? '',
    );
    _phoneController = TextEditingController(text: widget.address?.phone ?? '');
    _streetController = TextEditingController(
      text: widget.address?.street ?? '',
    );
    _cityController = TextEditingController(text: widget.address?.city ?? '');
    _governorateController = TextEditingController(
      text: widget.address?.governorate ?? '',
    );
    _countryController = TextEditingController(
      text: widget.address?.country ?? 'Egypt',
    );
    _labelController = TextEditingController(
      text: widget.address?.label ?? 'Home',
    );
    _isDefault = widget.address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _governorateController.dispose();
    _countryController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final address = AddressModel(
        id: widget.address?.id,
        fullName: _fullNameController.text.trim(),
        phone: _phoneController.text.trim(),
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        governorate: _governorateController.text.trim(),
        country: _countryController.text.trim(),
        label: _labelController.text.trim(),
        isDefault: _isDefault,
      );

      if (widget.address == null) {
        context.read<AddressCubit>().addAddress(address);
      } else {
        context.read<AddressCubit>().updateAddress(address);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.address != null;

    return Scaffold(
      appBar: AppBar(
        title: BasicText(
          text: isEditing ? 'edit_address'.tr() : 'add_new_address'.tr(),
          fontSize: 18.sp,
          isBold: true,
          color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor:
            Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressActionSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final isLoading = state is AddressActionLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField('full_name'.tr(), _fullNameController),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    'phone_number'.tr(),
                    _phoneController,
                    isPhone: true,
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField('street_address'.tr(), _streetController),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField('city'.tr(), _cityController),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildTextField(
                          'governorate'.tr(),
                          _governorateController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'country'.tr(),
                          _countryController,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildTextField(
                          'label_e_g_home_work'.tr(),
                          _labelController,
                          isRequired: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SwitchListTile(
                    title: BasicText(
                      text: 'set_as_default_address'.tr(),
                      fontSize: 14.sp,
                      color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                      isBold: false,
                    ),
                    value: _isDefault,
                    onChanged: (val) => setState(() => _isDefault = val),
                    activeColor: BasicColors.buttonColorDark,
                    contentPadding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : BasicButton(
                            text: isEditing
                                ? 'update_address'.tr()
                                : 'save_address'.tr(),
                            onPressed: _submit,
                            colors: const [BasicColors.buttonColorDark],
                            radius: 12.r,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isPhone = false,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicText(
          text: label,
          isBold: false,
          fontSize: 12.sp,
          color: const Color.fromARGB(255, 15, 23, 41),
        ),
        SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
            validator: isRequired
                ? (value) => value == null || value.isEmpty
                      ? 'required_field'.tr()
                      : null
                : null,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 12.w,
              ),
              filled: true,
              fillColor: const Color(0xFFFCFCFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: BasicColors.buttonColorDark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
