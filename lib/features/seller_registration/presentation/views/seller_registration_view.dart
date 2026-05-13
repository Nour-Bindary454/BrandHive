import 'dart:io';

import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/seller_registration/presentation/viewModel/seller_reg_cubit.dart';
import 'package:brand/features/seller_registration/presentation/viewModel/seller_reg_states.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/seller_reg_form_container.dart';
import 'package:brand/features/seller_registration/presentation/views/widgets/seller_reg_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellerRegistrationView extends StatelessWidget {
  const SellerRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BrandRequestCubit>(),
      child: const _SellerRegistrationBody(),
    );
  }
}

class _SellerRegistrationBody extends StatefulWidget {
  const _SellerRegistrationBody();

  @override
  State<_SellerRegistrationBody> createState() =>
      _SellerRegistrationBodyState();
}

class _SellerRegistrationBodyState extends State<_SellerRegistrationBody> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // ── Form Controllers ──
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // ── Form State ──
  String? _selectedCountry;
  List<String> _selectedCategoryIds = [];
  bool _shipsInternationally = false;

  File? _selectedLogo;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _websiteController.dispose();
    _whatsappController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _nextStep() {
    // Validate current step
    if (_currentStep == 0) {
      if (_phoneController.text.trim().isEmpty) {
        Toast.showErrorToast(
          msg: 'Please enter your phone number',
          context: context,
        );
        return;
      }
    } else if (_currentStep == 1) {
      if (_nameController.text.trim().isEmpty ||
          _descriptionController.text.trim().isEmpty) {
        Toast.showErrorToast(
          msg: 'Please fill in store name and description',
          context: context,
        );
        return;
      }
      if (_selectedCategoryIds.isEmpty) {
        Toast.showErrorToast(
          msg: 'Please select at least one category',
          context: context,
        );
        return;
      }
    } else if (_currentStep == 2) {
      if (_selectedCountry == null ||
          _selectedCountry!.isEmpty ||
          _cityController.text.trim().isEmpty) {
        Toast.showErrorToast(
          msg: 'Please select your country and enter your city',
          context: context,
        );
        return;
      }
    }

    if (_currentStep < 2) {
      setState(() => _currentStep++);

      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitBrandRequest();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);

      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _submitBrandRequest() {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final country = _selectedCountry ?? '';
    final city = _cityController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty ||
        description.isEmpty ||
        country.isEmpty ||
        city.isEmpty ||
        phone.isEmpty) {
      Toast.showErrorToast(
        msg:
            'Please fill in all required fields (Name, Phone, Description, Country, City)',
        context: context,
      );
      return;
    }

    if (_selectedCategoryIds.isEmpty) {
      Toast.showErrorToast(
        msg: 'Please select at least one category',
        context: context,
      );
      return;
    }

    context.read<BrandRequestCubit>().sendRequest(
      name: name,
      description: description,
      country: country,
      city: city,
      phone: phone,
      categories: _selectedCategoryIds,
      website: _websiteController.text.trim().isNotEmpty
          ? _websiteController.text.trim()
          : null,
      whatsappLink: _whatsappController.text.trim().isNotEmpty
          ? _whatsappController.text.trim()
          : null,
      shipsInternationally: _shipsInternationally,
      logo: _selectedLogo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrandRequestCubit, BrandRequestState>(
      listener: (context, state) {
        if (state is BrandRequestSuccess) {
          // Save state to prevent multiple requests
          CacheHelper.saveData(key: 'brand_request_pending', value: 'true');
          Navigator.pushReplacementNamed(context, '/sellerRegistrationSuccess');
        } else if (state is BrandRequestFailure) {
          Toast.showErrorToast(msg: state.error, context: context);
        }
      },
      builder: (context, state) {
        final cubit = context.read<BrandRequestCubit>();

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFFF9FAFB),
          body: Stack(
            children: [
              // ── Dark Blue Background ──
              SellerRegHeader(currentStep: _currentStep, onBack: _previousStep),

              // ── Header Content + Stepper + Form ──
              SafeArea(
                child: Column(
                  children: [
                    SellerRegHeaderContent(
                      currentStep: _currentStep,
                      onBack: _previousStep,
                    ),

                    // ── White Card + PageView ──
                    Expanded(
                      child: SellerRegFormContainer(
                        pageController: _pageController,
                        categories: cubit.categories,

                        nameController: _nameController,
                        descriptionController: _descriptionController,
                        websiteController: _websiteController,
                        whatsappController: _whatsappController,

                        selectedLogo: _selectedLogo,
                        onLogoSelected: (logo) {
                          setState(() {
                            _selectedLogo = logo;
                          });
                        },

                        selectedCategoryIds: _selectedCategoryIds,

                        onCategoriesChanged: (ids) =>
                            setState(() => _selectedCategoryIds = ids),

                        selectedCountry: _selectedCountry,

                        onCountryChanged: (value) =>
                            setState(() => _selectedCountry = value),

                        cityController: _cityController,
                        phoneController: _phoneController,

                        shipsInternationally: _shipsInternationally,

                        onShipsInternationallyChanged: (value) =>
                            setState(() => _shipsInternationally = value),

                        onBack: _previousStep,
                        onContinue: _nextStep,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Loading Overlay ──
              if (state is BrandRequestLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF2D4373)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
