import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/address_model.dart';
import '../../data/models/order_item_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/payment_model.dart';
import '../../data/repository/checkout_repository.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepository _repository;

  CheckoutCubit(this._repository) : super(CheckoutState());

  void initCheckout({
    required List<OrderItemModel> items,
    required double subtotal,
  }) {
    emit(state.copyWith(
      checkoutItems: items,
      subtotal: subtotal,
      currentStep: 1,
      error: null,
      orderSuccessResult: null,
    ));
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final addresses = await _repository.getSavedAddresses();
      emit(state.copyWith(
        isLoading: false,
        savedAddresses: addresses,
        selectedAddress: addresses.isNotEmpty ? addresses.first : null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: "Failed to load saved addresses.",
      ));
    }
  }

  void selectAddress(AddressModel address) {
    emit(state.copyWith(selectedAddress: address));
  }

  bool isAddressValid() {
    final address = state.selectedAddress;
    if (address == null) return false;
    return address.fullName.isNotEmpty &&
        address.phone.isNotEmpty &&
        address.street.isNotEmpty &&
        address.city.isNotEmpty &&
        address.country.isNotEmpty;
  }

  void selectPaymentMethod(PaymentModel payment) {
    emit(state.copyWith(selectedPayment: payment));
  }

  bool isPaymentValid() {
    final payment = state.selectedPayment;
    if (payment == null) return false;
    if (payment.methodType == PaymentMethodType.creditCard) {
      return payment.cardNumber != null &&
          payment.cardNumber!.isNotEmpty &&
          payment.expiryDate != null &&
          payment.expiryDate!.isNotEmpty &&
          payment.cvv != null &&
          payment.cvv!.isNotEmpty;
    }
    return true;
  }

  void nextStep() {
    if (state.currentStep == 1) {
      if (!isAddressValid()) {
        emit(state.copyWith(error: "Please complete all shipping address fields."));
        return;
      }
    } else if (state.currentStep == 2) {
      if (!isPaymentValid()) {
        emit(state.copyWith(error: "Please complete all payment details."));
        return;
      }
    }

    if (state.currentStep < 3) {
      emit(state.copyWith(currentStep: state.currentStep + 1, error: null));
    }
  }


  void previousStep() {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> placeOrder() async {
    if (state.selectedAddress == null || state.selectedPayment == null) {
      emit(state.copyWith(error: "Please complete shipping and payment details."));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));
    try {
      final order = OrderModel(
        shippingAddress: state.selectedAddress!,
        paymentMethod: state.selectedPayment!.methodType == PaymentMethodType.creditCard ? 'paymob' : 'cod',
        items: state.checkoutItems,
        subtotal: state.subtotal,

        shippingFee: state.shippingFee,
        total: state.totalAmount,
      );

      final result = await _repository.placeOrder(order);
      
      // Clear cart after successful order creation
      try {
        await _repository.clearCart();
      } catch (e) {
        // Log error but don't fail the checkout since order is already placed
        print('Failed to clear cart: $e');
      }

      emit(state.copyWith(
        isLoading: false,
        paymentUrl: result.paymentUrl,
        orderSuccessResult: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: "Failed to place order. Please try again.",
      ));
    }
  }

  void clearPaymentUrl() {
    emit(state.copyWith(paymentUrl: null));
  }

  void handlePaymentResult(bool success) {
    if (success) {
      // If success, we might want to refresh order status or just show success
      // For now, assuming if success is true, we show success screen
      // We can use the last orderSuccessResult if we stored it, 
      // or the repository might provide a way to get it.
      // Since we don't have the full response yet, we might need to fetch it or rely on the flag.
      emit(state.copyWith(
        orderSuccessResult: state.orderSuccessResult, // or trigger a refresh
        paymentUrl: null,
      ));
    } else {
      emit(state.copyWith(
        error: "Payment failed. Please try again.",
        paymentUrl: null,
      ));
    }
  }
}
