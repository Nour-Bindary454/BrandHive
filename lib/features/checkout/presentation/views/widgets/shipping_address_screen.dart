import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/svg_images/svg_images.dart';
import 'package:brand/features/checkout/presentation/views/widgets/custom_shipping_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/sharedWidgets/basic_colors.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  text: 'Shipping Address',
                  fontSize: 17.sp,
                  color: BasicColors.black,
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
                    label: 'First Name',
                    controller: _firstNameController,
                    isPhone: false,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CustomShippingForm(
                    context: context,
                    label: 'Last Name',
                    controller: _lastNameController,
                    isPhone: false,
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
            ),

            SizedBox(height: 14.h),

            CustomShippingForm(
              context: context,
              label: 'Street Address',
              controller: _streetController,
              isPhone: false,
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
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CustomShippingForm(
                    context: context,
                    label: 'Area/District',
                    controller: _areaController,
                    isPhone: false,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// 🔹 Saved Address UI (ONLY UI)
            _savedAddressUI(),
          ],
        ),
      ),
    );
  }

  /// ===================== SAVED ADDRESS UI =====================
  Widget _savedAddressUI() {
    final addresses = [
      {"title": "Home", "address": "12 Nile Street, Cairo, Egypt"},
    ];

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
            text: 'Saved Addresses',
            fontSize: 16.sp,
            color: BasicColors.black,
            isBold: true,
            fontFamily: 'Outfit',
          ),

          SizedBox(height: 10.h),

          ...addresses.map((address) {
            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  /// icon
                  CircleAvatar(
                    backgroundColor: const Color(0xFF2463EB).withOpacity(0.1),
                    child: const Icon(
                      Icons.location_on,
                      color: BasicColors.buttonColorDark,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  /// text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasicText(
                          text: address["title"]!,
                          fontSize: 14.sp,
                          color: BasicColors.black,
                          isBold: true,
                        ),
                        SizedBox(height: 3.h),
                        BasicText(
                          text: address["address"]!,
                          fontSize: 13.sp,
                          color: Colors.grey,
                          isBold: true,
                        ),
                      ],
                    ),
                  ),

                  /// radio UI only
                  Container(
                    width: 18.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
