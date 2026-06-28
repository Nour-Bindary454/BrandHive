import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/home/data/models/home_models.dart';

class ExploreState {
  final bool isLoading;
  final String? error;
  final List<HomeProduct> products;
  final List<HomeProduct> filteredProducts;
  final bool isFiltering;
  final String sortBy;
  final String category;
  final String minPrice;
  final String maxPrice;
  final String selectedShipping;
  final List<CategoryModel> categories;
  final List<Product> trendingProducts;

  ExploreState({
    this.isLoading = false,
    this.error,
    this.products = const [],
    this.filteredProducts = const [],
    this.isFiltering = false,
    this.sortBy = 'Featured',
    this.category = 'All',
    this.minPrice = '',
    this.maxPrice = '',
    this.selectedShipping = 'All',
    this.categories = const [],
    this.trendingProducts = const [],
  });

  ExploreState copyWith({
    bool? isLoading,
    String? error,
    List<HomeProduct>? products,
    List<HomeProduct>? filteredProducts,
    bool? isFiltering,
    String? sortBy,
    String? category,
    String? minPrice,
    String? maxPrice,
    String? selectedShipping,
    List<CategoryModel>? categories,
    List<Product>? trendingProducts,
  }) {
    return ExploreState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isFiltering: isFiltering ?? this.isFiltering,
      sortBy: sortBy ?? this.sortBy,
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      selectedShipping: selectedShipping ?? this.selectedShipping,
      categories: categories ?? this.categories,
      trendingProducts: trendingProducts ?? this.trendingProducts,
    );
  }
}

