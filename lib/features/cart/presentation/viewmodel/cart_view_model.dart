import 'package:flutter/material.dart';
import '../../data/model/cart_item_model.dart';
import '../../services/cart_service.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService;

  CartViewModel(this._cartService) {
    fetchCart();
  }

  List<CartItemModel> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CartItemModel> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  double get shippingCost => 50.0; // Fixed as per requirements

  double get total => _items.isEmpty ? 0.0 : subtotal + shippingCost;

  Future<void> fetchCart() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _items = await _cartService.fetchCartItems();
    } catch (e) {
      _errorMessage = 'Failed to load cart items.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(CartItemModel item) async {
    try {
      await _cartService.addItemToCart(item);
      final index = _items.indexWhere((element) => element.id == item.id);
      if (index >= 0) {
        _items[index].quantity += item.quantity;
      } else {
        _items.add(item);
      }
      notifyListeners();
    } catch (e) {
      // Handle error gracefully
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    if (quantity < 1) return;
    try {
      await _cartService.updateItemQuantity(productId, quantity);
      final index = _items.indexWhere((element) => element.id == productId);
      if (index >= 0) {
        _items[index].quantity = quantity;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> removeItem(String productId) async {
    try {
      await _cartService.removeItemFromCart(productId);
      _items.removeWhere((element) => element.id == productId);
      notifyListeners();
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
        _items.clear();
      }
    } catch (e) {
      _errorMessage = 'Checkout failed.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
