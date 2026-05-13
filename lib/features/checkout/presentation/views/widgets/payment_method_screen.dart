import 'package:brand/features/checkout/presentation/viewmodels/checkout_cubit.dart';
import 'package:brand/features/checkout/presentation/viewmodels/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/sharedWidgets/basic_colors.dart';
import '../../../data/models/payment_model.dart';

/// Formats card number as "XXXX XXXX XXXX XXXX"
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(' ', '');
    if (digits.length > 16) return oldValue;
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Formats expiry as "MM/YY"
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll('/', '');
    if (digits.length > 4) return oldValue;
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _cardNumController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

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

  @override
  void dispose() {
    _cardNumController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
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
        final selectedType =
            state.selectedPayment?.methodType ?? PaymentMethodType.creditCard;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(
                      Icons.credit_card,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.black,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.black,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // Card Holder Name
                        _buildInput(
                          'Card Holder Name',
                          _cardHolderController,
                          hint: 'JOHN DOE',
                          icon: Icons.person_outline,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z ]'),
                            ),
                            LengthLimitingTextInputFormatter(26),
                          ],
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Card holder name is required';
                            }
                            return null;
                          },
                          onChanged: (_) => _updatePayment(selectedType),
                        ),
                        SizedBox(height: 16.h),

                        // Card Number
                        _buildInput(
                          'Card Number',
                          _cardNumController,
                          hint: '0000 0000 0000 0000',
                          icon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            _CardNumberFormatter(),
                          ],
                          validator: (v) {
                            final digits =
                                (v ?? '').replaceAll(' ', '');
                            if (digits.length != 16) {
                              return 'Enter a valid 16-digit card number';
                            }
                            return null;
                          },
                          onChanged: (_) => _updatePayment(selectedType),
                        ),
                        SizedBox(height: 16.h),

                        Row(
                          children: [
                            // Expiry Date
                            Expanded(
                              child: _buildInput(
                                'Expiry Date',
                                _expiryController,
                                hint: 'MM/YY',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  _ExpiryDateFormatter(),
                                ],
                                validator: (v) {
                                  final parts = (v ?? '').split('/');
                                  if (parts.length != 2 ||
                                      parts[0].length != 2 ||
                                      parts[1].length != 2) {
                                    return 'Use MM/YY format';
                                  }
                                  final month = int.tryParse(parts[0]) ?? 0;
                                  if (month < 1 || month > 12) {
                                    return 'Invalid month';
                                  }
                                  return null;
                                },
                                onChanged: (_) => _updatePayment(selectedType),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            // CVV
                            Expanded(
                              child: _buildInput(
                                'CVV',
                                _cvvController,
                                hint: '•••',
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                validator: (v) {
                                  if ((v ?? '').length < 3) {
                                    return 'CVV must be 3-4 digits';
                                  }
                                  return null;
                                },
                                onChanged: (_) => _updatePayment(selectedType),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        // Card type icons
                        Row(
                          children: [
                            _cardBadge('VISA', Colors.blue.shade900),
                            SizedBox(width: 8.w),
                            _cardBadge('MC', Colors.red.shade700),
                            SizedBox(width: 8.w),
                            _cardBadge('MEEZA', const Color(0xFF2D4373)),
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

  Widget _cardBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
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
    final isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => _updatePayment(type),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? BasicColors.buttonColorDark : Colors.grey[300]!,
            width: isSelected ? 1.5 : 1,
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
              activeColor: BasicColors.buttonColorDark,
            ),
            Icon(
              iconData,
              color: isSelected ? BasicColors.buttonColorDark : Colors.grey,
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
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.black,
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
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey[400]),
            prefixIcon: icon != null ? Icon(icon, color: Colors.grey, size: 18.sp) : null,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
              borderSide: const BorderSide(color: BasicColors.buttonColorDark),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
