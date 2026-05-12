import '../../data/models/address_model.dart';
import '../../data/models/checkout_response_model.dart';
import '../../data/models/order_item_model.dart';
import '../../data/models/payment_model.dart';

class CheckoutState {
  final bool isLoading;
  final String? error;
  final int currentStep;
  
  final List<AddressModel> savedAddresses;
  final AddressModel? selectedAddress;
  final PaymentModel? selectedPayment;
  
  final List<OrderItemModel> checkoutItems;
  final double subtotal;
  final double shippingFee;
  final String? paymentUrl;
  final CheckoutResponseModel? orderSuccessResult;

  CheckoutState({
    this.isLoading = false,
    this.error,
    this.currentStep = 1,
    this.savedAddresses = const [],
    this.selectedAddress,
    this.selectedPayment,
    this.checkoutItems = const [],
    this.subtotal = 0.0,
    this.shippingFee = 50.0,
    this.paymentUrl,
    this.orderSuccessResult,
  });

  double get totalAmount => subtotal + shippingFee;

  CheckoutState copyWith({
    bool? isLoading,
    String? error,
    int? currentStep,
    List<AddressModel>? savedAddresses,
    AddressModel? selectedAddress,
    PaymentModel? selectedPayment,
    List<OrderItemModel>? checkoutItems,
    double? subtotal,
    double? shippingFee,
    String? paymentUrl,
    CheckoutResponseModel? orderSuccessResult,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      error: error, // Can be null to clear
      currentStep: currentStep ?? this.currentStep,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedPayment: selectedPayment ?? this.selectedPayment,
      checkoutItems: checkoutItems ?? this.checkoutItems,
      subtotal: subtotal ?? this.subtotal,
      shippingFee: shippingFee ?? this.shippingFee,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      orderSuccessResult: orderSuccessResult ?? this.orderSuccessResult,
    );
  }
}
