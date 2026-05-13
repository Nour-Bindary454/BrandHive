import 'package:brand/features/home/data/models/home_models.dart';

class BrandProfileState {
  final bool isLoading;
  final String? error;
  final List<HomeProduct> products;
  final BrandModel? brand;

  BrandProfileState({
    this.isLoading = false,
    this.error,
    this.products = const [],
    this.brand,
  });

  BrandProfileState copyWith({
    bool? isLoading,
    String? error,
    List<HomeProduct>? products,
    BrandModel? brand,
  }) {
    return BrandProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      products: products ?? this.products,
      brand: brand ?? this.brand,
    );
  }
}
