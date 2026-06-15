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
<<<<<<< HEAD
  final String shipping;
=======
  final String selectedShipping;
>>>>>>> b638b3040374aa6e62f93d89ede990324fbda31e
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
<<<<<<< HEAD
    this.shipping = 'All',
=======
    this.selectedShipping = 'All',
>>>>>>> b638b3040374aa6e62f93d89ede990324fbda31e
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
<<<<<<< HEAD
    String? shipping,
=======
    String? selectedShipping,
>>>>>>> b638b3040374aa6e62f93d89ede990324fbda31e
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
<<<<<<< HEAD
      shipping: shipping ?? this.shipping,
=======
      selectedShipping: selectedShipping ?? this.selectedShipping,
>>>>>>> b638b3040374aa6e62f93d89ede990324fbda31e
      categories: categories ?? this.categories,
      trendingProducts: trendingProducts ?? this.trendingProducts,
    );
  }
}

