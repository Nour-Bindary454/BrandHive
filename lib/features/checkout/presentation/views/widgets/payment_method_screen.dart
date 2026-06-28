import 'package:brand/features/checkout/presentation/viewmodels/checkout_cubit.dart';
import 'package:brand/features/checkout/presentation/viewmodels/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/sharedWidgets/basic_colors.dart';
import '../../../data/models/payment_model.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _cardNumController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CheckoutCubit>();
    if (cubit.state.selectedPayment != null) {
      _cardNumController.text = cubit.state.selectedPayment!.cardNumber ?? '';
      _expiryController.text = cubit.state.selectedPayment!.expiryDate ?? '';
      _cvvController.text = cubit.state.selectedPayment!.cvv ?? '';
    }
  }

  void _updatePayment(PaymentMethodType type) {
    context.read<CheckoutCubit>().selectPaymentMethod(
      PaymentModel(
        methodType: type,
        cardNumber: _cardNumController.text,
        expiryDate: _expiryController.text,
        cvv: _cvvController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final selectedType = state.selectedPayment?.methodType ?? PaymentMethodType.creditCard;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.credit_card, color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                _buildPaymentOption(
                  context,
                  PaymentMethodType.creditCard,
                  'Credit/Debit Card',
                  'Visa, Mastercard, Meeza',
                  Icons.credit_card_outlined,
                  selectedType,
                ),
                _buildPaymentOption(
                  context,
                  PaymentMethodType.cashOnDelivery,
                  'Cash on Delivery',
                  'Pay when you receive',
                  Icons.money,
                  selectedType,
                ),

                if (selectedType == PaymentMethodType.creditCard)
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        _buildInput(
                          'Card Number',
                          _cardNumController,
                          icon: Icons.credit_card,
                          onChanged: (_) => _updatePayment(selectedType),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInput(
                                'Expiry Date',
                                _expiryController,
                                hint: 'MM/YY',
                                onChanged: (_) => _updatePayment(selectedType),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: _buildInput(
                                'CVV',
                                _cvvController,
                                hint: '123',
                                onChanged: (_) => _updatePayment(selectedType),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    PaymentMethodType type,
    String title,
    String subtitle,
    IconData iconData,
    PaymentMethodType selectedType,
  ) {
    bool isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => _updatePayment(type),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? (BasicColors.buttonColorDark)
                : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Radio<PaymentMethodType>(
              value: type,
              groupValue: selectedType,
              onChanged: (val) {
                if (val != null) _updatePayment(val);
              },
              activeColor: (BasicColors.buttonColorDark),
            ),
            Icon(
              iconData,
              color: isSelected ? (BasicColors.buttonColorDark) : Colors.grey,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    TextEditingController controller, {
    String? hint,
    IconData? icon,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[800],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            filled: true,
            fillColor: BasicColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: (BasicColors.buttonColorDark)),
            ),
          ),
        ),
      ],
    );
  }
}

