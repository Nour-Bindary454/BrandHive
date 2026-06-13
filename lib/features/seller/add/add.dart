import 'dart:io';

import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/seller/add/widgets/add_product_text_field.dart';
import 'package:brand/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:brand/features/seller/presentation/view_model/seller_states.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  String? _selectedCategoryId;
  bool _isActive = true;
  bool _prefillDone = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SellerCubit>();
    if (cubit.categories.isEmpty) {
      cubit.loadCategories();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _costController.dispose();
    _skuController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _prefillFromEditing(SellerCubit cubit) {
    if (_prefillDone) return;
    final p = cubit.editingProduct;
    if (p != null) {
      _nameController.text = p.name;
      _descController.text = p.description;
      _priceController.text = p.price.toStringAsFixed(0);
      _stockController.text = p.stock.toString();
      _costController.text = p.costPrice?.toStringAsFixed(0) ?? '';
      _skuController.text = p.sku ?? '';
      _tagsController.text = p.tags.join(', ');
      _selectedCategoryId = p.categoryId;
      _isActive = p.isActive;
    }
    _prefillDone = true;
  }

  void _clearForm(SellerCubit cubit) {
    _nameController.clear();
    _descController.clear();
    _priceController.clear();
    _stockController.clear();
    _costController.clear();
    _skuController.clear();
    _tagsController.clear();
    setState(() {
      _selectedCategoryId = null;
      _isActive = true;
      _prefillDone = false;
    });
    cubit.clearEditingProduct();
  }

  void _submit(SellerCubit cubit) {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final desc = _descController.text.trim();
    final price = double.tryParse(_priceController.text.trim()) ?? 0;
    final stock = int.tryParse(_stockController.text.trim()) ?? 0;
    final cost = double.tryParse(_costController.text.trim());
    final sku = _skuController.text.trim().isNotEmpty
        ? _skuController.text.trim()
        : null;
    final tags = _tagsController.text.trim().isNotEmpty
        ? _tagsController.text.trim().split(',').map((e) => e.trim()).toList()
        : <String>[];

    if (_selectedCategoryId == null) {
      Toast.showErrorToast(msg: 'Please select a category', context: context);
      return;
    }

    if (cubit.editingProduct != null) {
      cubit.updateProduct(
        productId: cubit.editingProduct!.id,
        name: name,
        description: desc,
        price: price,
        stock: stock,
        categoryId: _selectedCategoryId!,
        costPrice: cost,
        sku: sku,
        tags: tags,
        isActive: _isActive,
      );
    } else {
      cubit.createProduct(
        name: name,
        description: desc,
        price: price,
        stock: stock,
        categoryId: _selectedCategoryId!,
        costPrice: cost,
        sku: sku,
        tags: tags,
        isActive: _isActive,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<SellerCubit, SellerState>(
          listener: (context, state) {
            if (state is SellerProductActionSuccess) {
              Toast.showSuccessToast(msg: state.message, context: context);
              _clearForm(context.read<SellerCubit>());
              try {
                context.read<HomeCubit>().loadHomeData(isRefresh: true);
              } catch (e) {
                debugPrint('Failed to refresh HomeCubit: $e');
              }
            } else if (state is SellerProductActionFailure) {
              Toast.showErrorToast(msg: state.error, context: context);
            } else if (state is SellerInitial) {
              // Triggered when editingProduct changes — re-prefill
              _prefillDone = false;
            }
          },
          builder: (context, state) {
            final cubit = context.read<SellerCubit>();
            _prefillFromEditing(cubit);

            final isEditing = cubit.editingProduct != null;
            final isLoading = state is SellerProductActionLoading;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: BasicText(
                            text: isEditing
                                ? 'Edit Product'.tr()
                                : 'add_new_product'.tr(),
                            fontSize: 18,
                            color: const Color(0xFF0F172A),
                            isBold: true,
                          ),
                        ),
                        if (isEditing)
                          TextButton.icon(
                            onPressed: () => _clearForm(cubit),
                            icon: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.grey,
                            ),
                            label: BasicText(
                              text: 'New',
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              isBold: true,
                            ),
                          ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 100.h),
                      children: [
                        // ── Image Section ──
                        _buildImageSection(context, cubit),

                        // ── Product Details ──
                        SettingsCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BasicText(
                                text: 'product_details'.tr(),
                                fontSize: 14,
                                color: const Color(0xFF0F172A),
                                isBold: true,
                              ),
                              SizedBox(height: 15.h),
                              _buildField(
                                controller: _nameController,
                                label: 'Product Name *',
                                hint: 'e.g. Handwoven Kilim Rug',
                                validator: (v) =>
                                    v == null || v.isEmpty ? 'Required' : null,
                              ),
                              SizedBox(height: 12.h),
                              _buildField(
                                controller: _descController,
                                label: 'Description *',
                                hint: 'Describe your product...',
                                maxLines: 4,
                                validator: (v) =>
                                    v == null || v.isEmpty ? 'Required' : null,
                              ),
                              SizedBox(height: 12.h),
                              // Category Dropdown
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6.h),
                                    child: BasicText(
                                      text: 'Category *',
                                      fontSize: 11,
                                      color: const Color(0xFF1F2937),
                                      isBold: true,
                                    ),
                                  ),
                                  DropdownButtonFormField<String>(
                                    value:
                                        cubit.categories.any(
                                          (cat) =>
                                              cat.id == _selectedCategoryId,
                                        )
                                        ? _selectedCategoryId
                                        : null,
                                    hint: state is SellerCategoriesLoading
                                        ? SizedBox(
                                            width: 15.w,
                                            height: 15.h,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Color(0xFF1B354D),
                                              ),
                                            ),
                                          )
                                        : BasicText(
                                            text: 'Select a category',
                                            fontSize: 12,
                                            color: Colors.grey.shade400,
                                          ),
                                    items: cubit.categories.map((cat) {
                                      return DropdownMenuItem(
                                        value: cat.id,
                                        child: Text(
                                          cat.name,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) => setState(
                                      () => _selectedCategoryId = val,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 12.h,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF1B354D),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              _buildField(
                                controller: _skuController,
                                label: 'SKU (Optional)',
                                hint: 'e.g. KLM-001',
                              ),
                            ],
                          ),
                        ),

                        // ── Pricing & Stock ──
                        SettingsCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BasicText(
                                text: 'pricing_stock'.tr(),
                                fontSize: 14,
                                color: const Color(0xFF0F172A),
                                isBold: true,
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _buildField(
                                      controller: _priceController,
                                      label: 'Price (EGP) *',
                                      hint: '1200',
                                      keyboardType: TextInputType.number,
                                      validator: (v) {
                                        if (v == null || v.isEmpty)
                                          return 'Required';
                                        if (double.tryParse(v) == null)
                                          return 'Invalid';
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: _buildField(
                                      controller: _stockController,
                                      label: 'Stock Quantity *',
                                      hint: '10',
                                      keyboardType: TextInputType.number,
                                      validator: (v) {
                                        if (v == null || v.isEmpty)
                                          return 'Required';
                                        if (int.tryParse(v) == null)
                                          return 'Invalid';
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              _buildField(
                                controller: _costController,
                                label: 'Cost Price (EGP) (Optional)',
                                hint: '800',
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),

                        // ── SEO & Visibility ──
                        SettingsCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BasicText(
                                text: 'seo_visibility'.tr(),
                                fontSize: 14,
                                color: const Color(0xFF0F172A),
                                isBold: true,
                              ),
                              SizedBox(height: 15.h),
                              _buildField(
                                controller: _tagsController,
                                label: 'Tags (comma separated)',
                                hint: 'handmade, egyptian, rug',
                              ),
                              SizedBox(height: 15.h),
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _isActive = !_isActive),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 16.r,
                                        height: 16.r,
                                        decoration: BoxDecoration(
                                          color: _isActive
                                              ? const Color(0xFFFACC15)
                                              : Colors.white,
                                          border: Border.all(
                                            color: _isActive
                                                ? Colors.transparent
                                                : Colors.grey.shade400,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            2.r,
                                          ),
                                        ),
                                        child: _isActive
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.black,
                                                size: 12.sp,
                                              )
                                            : const SizedBox(),
                                      ),
                                      SizedBox(width: 10.w),
                                      BasicText(
                                        text: 'publish_this_product_immediately'
                                            .tr(),
                                        fontSize: 11,
                                        color: const Color(0xFF0F172A),
                                        isBold: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ── Actions ──
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => _clearForm(cubit),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xFF2D4373),
                                      width: 1.2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.r),
                                    ),
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
                                  onPressed: isLoading
                                      ? null
                                      : () => _submit(cubit),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2D4373),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.r),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : BasicText(
                                          text: isEditing
                                              ? 'Update Product'.tr()
                                              : 'publish_product'.tr(),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, SellerCubit cubit) {
    final File? picked = cubit.pickedImage;
    final String? existingUrl = cubit.editingProduct?.image;

    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'product_images'.tr(),
            fontSize: 14,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              GestureDetector(
                onTap: () => cubit.pickImage(),
                child: Container(
                  width: 90.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: picked != null
                          ? const Color(0xFF2D4373)
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: picked != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.file(picked, fit: BoxFit.cover),
                        )
                      : existingUrl != null && existingUrl.startsWith('http')
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            existingUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _addPhotoPlaceholder(context),
                          ),
                        )
                      : _addPhotoPlaceholder(context),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: 'Tap to select photo',
                      fontSize: 12,
                      color: const Color(0xFF0F172A),
                      isBold: true,
                    ),
                    SizedBox(height: 4.h),
                    BasicText(
                      text: 'upload_up_to_5_photos_recommended_800x800px'.tr(),
                      fontSize: 10,
                      color: Colors.grey.shade500,
                    ),
                    if (picked != null) ...[
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () => cubit.clearPickedImage(),
                        child: BasicText(
                          text: 'Remove',
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
    );
  }

  Widget _addPhotoPlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          color: Colors.grey.shade500,
          size: 24.sp,
        ),
        SizedBox(height: 4.h),
        BasicText(
          text: 'add_photo'.tr(),
          fontSize: 10,
          color: Colors.grey.shade500,
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return AddProductTextField(
      label: label,
      hintText: hint,
      maxLines: maxLines,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
    );
  }
}
