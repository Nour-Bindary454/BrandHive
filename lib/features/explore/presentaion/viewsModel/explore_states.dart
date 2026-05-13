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
  final List<CategoryModel> categories;

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
    this.categories = const [],
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
    List<CategoryModel>? categories,
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
      categories: categories ?? this.categories,
    );
  }
}
