import '../data/model/cart_item_model.dart';
import '../data/repository/cart_repository.dart';

class CartService {
  final CartRepository _repository;

  CartService(this._repository);

  Future<List<CartItemModel>> fetchCartItems() async {
    return await _repository.getCartItems();
  }

  Future<void> addItemToCart(CartItemModel item) async {
    await _repository.addToCart(item);
  }

  Future<void> removeItemFromCart(String productId) async {
    await _repository.removeFromCart(productId);
  }

  Future<void> updateItemQuantity(String productId, int newQuantity) async {
    if (newQuantity < 1) return; // Enforce UI rule in business logic
    await _repository.updateQuantity(productId, newQuantity);
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
