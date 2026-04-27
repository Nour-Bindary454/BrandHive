import 'package:flutter/material.dart';
import '../../data/models/address_model.dart';
import '../../data/models/order_item_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/payment_model.dart';
import '../../data/repository/checkout_repository.dart';

class CheckoutViewModel extends ChangeNotifier {
  final CheckoutRepository _repository;

  CheckoutViewModel(this._repository);

  // States
  bool _isLoading = false;
  String? _errorMessage;
  int _currentStep = 1; // 1: Shipping, 2: Payment, 3: Review

  // Form Data
  AddressModel? _selectedAddress;
  PaymentModel? _selectedPayment;
  OrderModel? _finalOrderResult;

  // Cart Data passed in
  List<OrderItemModel> _checkoutItems = [];
  double _subtotal = 0.0;
  double _shippingFee = 50.0;

  // Address List
  List<AddressModel> _savedAddresses = [];

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get currentStep => _currentStep;
  AddressModel? get selectedAddress => _selectedAddress;
  PaymentModel? get selectedPayment => _selectedPayment;
  OrderModel? get finalOrderResult => _finalOrderResult;
  List<AddressModel> get savedAddresses => _savedAddresses;

  double get totalAmount => _subtotal + _shippingFee;

  // --- Initialization ---

  void initCheckout(List<OrderItemModel> items, double subtotal) {
    _checkoutItems = items;
    _subtotal = subtotal;
    _currentStep = 1;
    _selectedAddress = null;
    _selectedPayment = null;
    _finalOrderResult = null;
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    _isLoading = true;
    notifyListeners();
    try {
      _savedAddresses = await _repository.getSavedAddresses();
      if (_savedAddresses.isNotEmpty) {
        _selectedAddress = _savedAddresses.first; // default select
      }
    } catch (e) {
      _errorMessage = "Failed to load saved addresses.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- Step 1: Shipping ---

  void selectAddress(AddressModel address) {
    _selectedAddress = address;
    notifyListeners();
  }

  void setCustomAddress(AddressModel customAddress) {
    _selectedAddress = customAddress;
    notifyListeners();
  }

  void submitShippingStep() {
    if (_selectedAddress != null) {
      _currentStep = 2;
      notifyListeners();
    }
  }

  // --- Step 2: Payment ---

  void selectPaymentMethod(PaymentModel paymentMethod) {
    _selectedPayment = paymentMethod;
    notifyListeners();
  }

  void submitPaymentStep() {
    if (_selectedPayment != null) {
      _currentStep = 3;
      notifyListeners();
    }
  }

  // --- Step 3: Review & Place Order ---

  void goBackStep() {
    if (_currentStep > 1) {
      _currentStep--;
      notifyListeners();
    }
  }

  Future<bool> placeOrder() async {
    if (_selectedAddress == null || _selectedPayment == null) {
      _errorMessage = "Missing address or payment information.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newOrder = OrderModel(
        shippingAddress: _selectedAddress!,
        paymentMethod: _selectedPayment!,
        items: _checkoutItems,
        subtotal: _subtotal,
        shippingFee: _shippingFee,
        totalAmount: totalAmount,
        createdAt: DateTime.now(),
      );

      final orderId = await _repository.placeOrder(newOrder);

      // Create final result including ID returned from server
      _finalOrderResult = OrderModel(
        orderId: orderId,
        shippingAddress: newOrder.shippingAddress,
        paymentMethod: newOrder.paymentMethod,
        items: newOrder.items,
        subtotal: newOrder.subtotal,
        shippingFee: newOrder.shippingFee,
        totalAmount: newOrder.totalAmount,
        createdAt: newOrder.createdAt,
      );

      return true;
    } catch (e) {
      _errorMessage = "Failed to place order. Please try again.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset after leave
  void reset() {
    _currentStep = 1;
    _selectedAddress = null;
    _selectedPayment = null;
    _finalOrderResult = null;
  }
}
