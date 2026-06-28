import 'package:flutter/material.dart';
import 'package:brand/core/services/event_tracker.dart';
import '../../data/model/cart_item_model.dart';
import '../../data/model/cart_response_model.dart';
import '../../services/cart_service.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService;

  CartViewModel(this._cartService) {
    fetchCart();
  }

  CartDataModel? _cartData;
  List<CartItemModel> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CartItemModel> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  double get subtotal => _cartData?.subtotal ?? 0.0;

  double get shippingCost => 50.0; // Keep local or get from API if available

  double get total => _cartData?.total ?? (_items.isEmpty ? 0.0 : subtotal + shippingCost);

  Future<void> fetchCart() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _cartData = await _cartService.fetchCartItems();
      _items = _cartData?.items ?? [];
    } catch (e) {
      _errorMessage = 'Failed to load cart items.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(String productId, {int quantity = 1}) async {
    try {
      await _cartService.addItemToCart(productId, quantity: quantity);
      EventTracker.track(productId: productId, event: 'cart');
      await fetchCart(); // Refresh the cart from server to ensure data is synced
    } catch (e) {
      // Handle error gracefully
    }
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    if (quantity < 1) return;
    try {
      await _cartService.updateItemQuantity(itemId, quantity);
      await fetchCart();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> removeItem(String itemId) async {
    try {
      await _cartService.removeItemFromCart(itemId);
      await fetchCart();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> checkout() async {
    _isLoading = true;
    notifyListeners();
    try {
      final success = await _cartService.processCheckout(_items, total);
      if (success) {
        clearCartLocal();
      }
    } catch (e) {
      _errorMessage = 'Checkout failed.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearCartLocal() {
    _items = [];
    _cartData = null;
    notifyListeners();
  }
}
