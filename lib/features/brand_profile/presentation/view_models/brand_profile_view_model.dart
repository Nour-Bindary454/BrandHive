import 'package:brand/core/utils/appImages/png_images.dart';

import 'package:flutter/material.dart';
import '../../data/models/brand_model.dart';
import '../../data/models/product_model.dart';

class BrandProfileViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  Brand? _brand;
  List<Product> _products = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  Brand? get brand => _brand;
  List<Product> get products => _products;

  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // API Simulation delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock Data
      _brand = Brand(
        id: '1',
        name: 'Cairo Leather',
        logo: PngImages.bag,
        coverImage: PngImages.logo,
        rating: 4.7,
        reviewCount: 120,
        description:
            'Premium handcrafted leather goods made in the heart of Old Cairo. Sustainable and timeless designs.',
        location: 'Cairo, Egypt',
        memberSince: '2023',
        isFollowed: false,
      );

      _products = List.generate(
        5,
        (index) => Product(
          id: 'p$index',
          brandId: '1',
          name: index % 2 == 0 ? 'Classic Tote Bag' : 'Leather Wallet',
          image: index % 2 == 0 ? PngImages.bag : PngImages.bag,
          rating: 4.8,
          price: 900.0 + (index * 50),
          currency: 'EGP',
          isFavorite: false,
        ),
      );
    } catch (e) {
      _error = 'Failed to load brand profile';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFollow() {
    if (_brand != null) {
      _brand = _brand!.copyWith(isFollowed: !_brand!.isFollowed);
      notifyListeners();
    }
  }

  void toggleFavorite(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index] = _products[index].copyWith(
        isFavorite: !_products[index].isFavorite,
      );
      notifyListeners();
    }
  }
}
