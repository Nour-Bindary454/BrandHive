import 'package:brand/features/home/data/models/home_models.dart';

class BrandProfileState {
  final bool isLoading;
  final String? error;
  final List<HomeProduct> products;

  BrandProfileState({
    this.isLoading = false,
    this.error,
    this.products = const [],
  });

  BrandProfileState copyWith({
    bool? isLoading,
    String? error,
    List<HomeProduct>? products,
  }) {
    return BrandProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error, // overwrite with null or string
      products: products ?? this.products,
    );
  }
}
