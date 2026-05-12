import 'package:brand/features/checkout/data/models/address_model.dart';
import 'package:brand/features/checkout/presentation/viewmodels/checkout_cubit.dart';
import 'package:brand/features/checkout/presentation/viewmodels/checkout_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/svg_images/svg_images.dart';
import 'package:brand/features/checkout/presentation/views/widgets/custom_shipping_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/sharedWidgets/basic_colors.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CheckoutCubit>();
    if (cubit.state.selectedAddress != null) {
      _fullNameController.text = cubit.state.selectedAddress!.fullName;
      _phoneController.text = cubit.state.selectedAddress!.phone;
      _streetController.text = cubit.state.selectedAddress!.street;
      _cityController.text = cubit.state.selectedAddress!.city;
      _areaController.text = cubit.state.selectedAddress!.country;
    }
  }

  void _updateAddress() {
    context.read<CheckoutCubit>().selectAddress(
      AddressModel(
        governorate: '',
        fullName: _fullNameController.text,

        phone: _phoneController.text,
        street: _streetController.text,
        city: _cityController.text,
        country: _areaController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Title
                Row(
                  children: [
                    SvgPicture.asset(SvgImages.locationdark),
                    SizedBox(width: 8.w),
                    BasicText(
                      text: 'shipping_address'.tr().tr(),
                      fontSize: 17.sp,
                      color:
                          Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.black,
                      isBold: true,
                      fontFamily: 'Outfit',
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                /// 🔹 Form
                Row(
                  children: [
                    Expanded(
                      child: CustomShippingForm(
                        context: context,
                        label: 'Full Name',
                        controller: _fullNameController,
                        isPhone: false,
                        onChanged: (_) => _updateAddress(),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                CustomShippingForm(
                  context: context,
                  label: 'Phone Number',
                  controller: _phoneController,
                  isPhone: true,
                  onChanged: (_) => _updateAddress(),
                ),

                SizedBox(height: 14.h),

                CustomShippingForm(
                  context: context,
                  label: 'Street Address',
                  controller: _streetController,
                  isPhone: false,
                  onChanged: (_) => _updateAddress(),
                ),

                SizedBox(height: 14.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomShippingForm(
                        context: context,
                        label: 'City',
                        controller: _cityController,
                        isPhone: false,
                        onChanged: (_) => _updateAddress(),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomShippingForm(
                        context: context,
                        label: 'Area/District',
                        controller: _areaController,
                        isPhone: false,
                        onChanged: (_) => _updateAddress(),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                /// 🔹 Saved Address UI
                if (state.savedAddresses.isNotEmpty)
                  _savedAddressUI(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _savedAddressUI(BuildContext context, CheckoutState state) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'saved_addresses'.tr().tr(),
            fontSize: 16.sp,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            isBold: true,
            fontFamily: 'Outfit',
          ),

          SizedBox(height: 10.h),

          ...state.savedAddresses.map((address) {
            bool isSelected = state.selectedAddress?.id == address.id;
            return GestureDetector(
              onTap: () {
                context.read<CheckoutCubit>().selectAddress(address);
                _fullNameController.text = address.fullName;
                _phoneController.text = address.phone;
                _streetController.text = address.street;
                _cityController.text = address.city;
                _areaController.text = address.country;
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: isSelected
                        ? BasicColors.buttonColorDark
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF2463EB).withOpacity(0.1),
                      child: const Icon(
                        Icons.location_on,
                        color: BasicColors.buttonColorDark,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BasicText(
                            text: "Address", // or address title if available
                            fontSize: 14.sp,
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                Colors.black,
                            isBold: true,
                          ),
                          SizedBox(height: 3.h),
                          BasicText(
                            text: "${address.street}, ${address.city}",
                            fontSize: 13.sp,
                            color: Colors.grey,
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 18.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? BasicColors.buttonColorDark
                              : Colors.grey,
                        ),
                        color: isSelected
                            ? BasicColors.buttonColorDark
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
