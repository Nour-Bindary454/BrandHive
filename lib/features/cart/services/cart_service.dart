import '../data/model/cart_item_model.dart';
import '../data/model/cart_response_model.dart';
import '../data/repository/cart_repository.dart';

class CartService {
  final CartRepository _repository;

  CartService(this._repository);

  Future<CartDataModel> fetchCartItems() async {
    return await _repository.getCartItems();
  }

  Future<CartDataModel> addItemToCart(
    String productId, {
    int quantity = 1,
  }) async {
    return await _repository.addToCart(productId, quantity: quantity);
  }

  Future<CartDataModel> removeItemFromCart(String productId) async {
    print('REMOVE PRODUCT ID => $productId');

    return await _repository.removeFromCart(productId);
  }

  Future<CartDataModel> updateItemQuantity(
    String productId,
    int newQuantity,
  ) async {
    print('UPDATE PRODUCT ID => $productId');

    if (newQuantity < 1) {
      return await fetchCartItems();
    }

    return await _repository.updateQuantity(productId, newQuantity);
  }

  Future<bool> processCheckout(List<CartItemModel> items, double total) async {
    if (items.isEmpty) return false;

    final cartData = {
      'items': items.map((e) => e.toJson()).toList(),
      'total': total,
    };

    return await _repository.checkout(cartData);
  }
}
