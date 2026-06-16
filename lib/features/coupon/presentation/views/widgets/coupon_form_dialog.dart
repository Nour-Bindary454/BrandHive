import 'package:brand/features/coupon/data/models/coupon_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponFormDialog extends StatefulWidget {
  final CouponModel? coupon;
  final Future<bool> Function({
    required String code,
    required String type,
    required double value,
    required DateTime expiresAt,
    String? description,
    double? minOrderAmount,
  }) onSubmit;

  const CouponFormDialog({
    super.key,
    this.coupon,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    CouponModel? coupon,
    required Future<bool> Function({
      required String code,
      required String type,
      required double value,
      required DateTime expiresAt,
      String? description,
      double? minOrderAmount,
    }) onSubmit,
  }) {
    return showDialog(
      context: context,
      builder: (_) => CouponFormDialog(coupon: coupon, onSubmit: onSubmit),
    );
  }

  @override
  State<CouponFormDialog> createState() => _CouponFormDialogState();
}

class _CouponFormDialogState extends State<CouponFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeController;
  late final TextEditingController _valueController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _minOrderController;
  String _type = 'percentage';
  DateTime _expiresAt = DateTime.now().add(const Duration(days: 30));
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final coupon = widget.coupon;
    _codeController = TextEditingController(text: coupon?.code ?? '');
    _valueController = TextEditingController(
      text: coupon != null ? coupon.value.toStringAsFixed(0) : '',
    );
    _descriptionController = TextEditingController(
      text: coupon?.description ?? '',
    );
    _minOrderController = TextEditingController(
      text: coupon != null && coupon.minOrderAmount > 0
          ? coupon.minOrderAmount.toStringAsFixed(0)
          : '',
    );
    if (coupon != null) {
      _type = coupon.type;
      _expiresAt = coupon.expiresAt ?? _expiresAt;
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _valueController.dispose();
    _descriptionController.dispose();
    _minOrderController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiresAt,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() => _expiresAt = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      final success = await widget.onSubmit(
        code: _codeController.text.trim(),
        type: _type,
        value: double.parse(_valueController.text.trim()),
        expiresAt: _expiresAt,
        description: _descriptionController.text.trim(),
        minOrderAmount: _minOrderController.text.trim().isEmpty
            ? null
            : double.tryParse(_minOrderController.text.trim()),
      );
      if (success && mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.coupon != null;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Text(
        isEdit ? 'edit_coupon'.tr() : 'create_coupon'.tr(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _codeController,
                enabled: !isEdit,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'coupon_code'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: InputDecoration(
                  labelText: 'coupon_type'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'percentage',
                    child: Text('coupon_percentage'.tr()),
                  ),
                  DropdownMenuItem(
                    value: 'fixed',
                    child: Text('coupon_fixed'.tr()),
                  ),
                ],
                onChanged: (v) => setState(() => _type = v ?? 'percentage'),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: _type == 'percentage'
                      ? 'coupon_value_percent'.tr()
                      : 'coupon_value_amount'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  if (double.tryParse(v.trim()) == null) return 'Invalid';
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'coupon_expires'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_expiresAt.day}/${_expiresAt.month}/${_expiresAt.year}',
                      ),
                      const Icon(Icons.calendar_today, size: 18),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _minOrderController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'coupon_min_order'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'description'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: Text('cancel'.tr()),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2D4373),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: _isSubmitting
              ? SizedBox(
                  width: 18.w,
                  height: 18.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(isEdit ? 'update'.tr() : 'create'.tr()),
        ),
      ],
    );
  }
}
