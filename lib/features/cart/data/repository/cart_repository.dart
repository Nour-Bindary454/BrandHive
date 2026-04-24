import '../model/cart_item_model.dart';

class CartRepository {
  // Mock internal database for offline/local cart testing
  final List<CartItemModel> _mockDatabase = [
    CartItemModel(
      id: 'p1',
      name: 'Split-Hem Flare Pants',
      brand: 'CARENA',
      price: 799.0,
      image:
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=300&q=80',
      quantity: 1,
    ),
    CartItemModel(
      id: 'p2',
      name: 'Cafe Elegance Scarf',
      brand: 'EMAA',
      price: 450.0,
      image:
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=300&q=80',
      quantity: 1,
    ),
  ];

  /// Fetch items from the server (mocked as local array)
  Future<List<CartItemModel>> getCartItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_mockDatabase);
  }

  /// Add new product to cart backend
  Future<bool> addToCart(CartItemModel product) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockDatabase.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _mockDatabase[index].quantity += product.quantity;
    } else {
      _mockDatabase.add(product);
    }
    return true;
  }

  /// Remove item from cart backend
  Future<bool> removeFromCart(String productId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockDatabase.removeWhere((item) => item.id == productId);
    return true;
  }

  /// Update item quantity on backend
  Future<bool> updateQuantity(String productId, int quantity) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _mockDatabase.indexWhere((item) => item.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _mockDatabase.removeAt(index);
      } else {
        _mockDatabase[index].quantity = quantity;
      }
      return true;
    }
    return false;
  }

  /// Checkout items
  Future<bool> checkout(Map<String, dynamic> cartData) async {
    await Future.delayed(const Duration(seconds: 2));
    // Clear cart upon successful checkout
    _mockDatabase.clear();
    return true;
  }
}
