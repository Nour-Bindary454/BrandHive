import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';

import '../model/cart_response_model.dart';

class CartRepository {
  final ApiService _apiService;

  CartRepository(this._apiService);

  /// Get Cart
  Future<CartDataModel> getCartItems() async {
    final response = await _apiService.getData(endPoint: EndPoints.cart);

    return CartDataModel.fromJson(response.data['data'] ?? {});
  }

  /// Add Item
  Future<CartDataModel> addToCart(String productId, {int quantity = 1}) async {
    final response = await _apiService.postData(
      endPoint: '${EndPoints.cart}/add',
      data: {'productId': productId, 'quantity': quantity},
    );

    return CartDataModel.fromJson(response.data['data'] ?? {});
  }

  /// Update Quantity
  Future<CartDataModel> updateQuantity(String productId, int quantity) async {
    final response = await _apiService.patchData(
      endPoint: '${EndPoints.cart}/update',
      data: {'productId': productId, 'quantity': quantity},
    );

    return CartDataModel.fromJson(response.data['data'] ?? {});
  }

  /// Remove Item
  Future<CartDataModel> removeFromCart(String productId) async {
    print('DELETE => ${EndPoints.cart}');

    final response = await _apiService.deleteData(
      endPoint: '${EndPoints.cart}/remove/$productId',
    );

    return CartDataModel.fromJson(response.data['data'] ?? {});
  }

  /// Checkout
  Future<bool> checkout(Map<String, dynamic> cartData) async {
    await _apiService.postData(endPoint: 'orders', data: cartData);

    return true;
  }
}
