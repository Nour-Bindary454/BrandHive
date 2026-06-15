import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/explore/data/repository/explore_repo.dart';
import 'package:brand/features/explore/presentaion/viewsModel/explore_states.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepository repo;

  ExploreCubit(this.repo) : super(ExploreState());

  Future<void> getProducts() async {
    if (state.products.isNotEmpty) return;

    emit(state.copyWith(isLoading: true, error: null));

    final result = await repo.getAllProducts(page: 1);

    // Fetch trending products from API
    List<Product> trending = [];
    final trendingResult = await repo.getTrendingProducts();
    trendingResult.fold(
      (_) {},
      (trendingProducts) {
        trending = trendingProducts;
      },
    );

    // Also fetch categories from API
    List<CategoryModel> categories = [];
    final catResult = await sl<HomeRepository>().getAllCategories();
    catResult.fold(
      (_) {},
      (cats) {
        categories = cats;
      },
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.errMessage));
      },
      (products) {
        emit(
          state.copyWith(
            isLoading: false,
            products: products,
            filteredProducts: products,
            categories: categories,
            trendingProducts: trending,
          ),
        );
      },
    );
  }

  Future<void> filterProducts({
    String? sortBy,
    String? category,
    String? minPrice,
    String? maxPrice,
    String? selectedShipping,
  }) async {
    List<HomeProduct> result;
    final shippingFilter = selectedShipping ?? state.selectedShipping;

    // Check if we need to filter by international shipping from the API
    if (shippingFilter != 'All') {
      emit(state.copyWith(isLoading: true));
      final bool isGlobal = shippingFilter == 'Global Only';
      final apiResult = await repo.searchProducts('', shipsInternationally: isGlobal);
      result = apiResult.fold(
        (_) => <HomeProduct>[],
        (products) => products,
      );
      emit(state.copyWith(isLoading: false));

      // Apply category filter locally if selected
      if (category != null && category != 'All') {
        result = result
            .where((p) => p.category.toLowerCase() == category.toLowerCase())
            .toList();
      }
    } else {
      // If shipping is 'All', follow existing category fetching logic
      if (category != null && category != 'All') {
        final cat = state.categories.firstWhere(
          (c) => c.name.toLowerCase() == category.toLowerCase(),
          orElse: () => CategoryModel(id: '', name: category, slug: ''),
        );

        if (cat.id.isNotEmpty) {
          emit(state.copyWith(isLoading: true));
          final apiResult = await sl<HomeRepository>().getProductsByCategory(cat.id);
          result = apiResult.fold(
            (_) => <HomeProduct>[],
            (products) => products,
          );
          emit(state.copyWith(isLoading: false));
        } else {
          // Fallback to local filtering
          result = state.products
              .where((p) => p.category.toLowerCase() == category.toLowerCase())
              .toList();
        }
      } else {
        result = List.from(state.products);
      }
    }

    // Apply Price Filter
    if (minPrice != null && minPrice.isNotEmpty) {
      final min = double.tryParse(minPrice);
      if (min != null) {
        result = result.where((p) => p.price >= min).toList();
      }
    }
    if (maxPrice != null && maxPrice.isNotEmpty) {
      final max = double.tryParse(maxPrice);
      if (max != null) {
        result = result.where((p) => p.price <= max).toList();
      }
    }

    // Apply Sort
    if (sortBy != null) {
      if (sortBy == 'Price: Low') {
        result.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortBy == 'Price: High') {
        result.sort((a, b) => b.price.compareTo(a.price));
      } else if (sortBy == 'Top Rated') {
        result.sort((a, b) => b.rating.compareTo(a.rating));
      }
    }

    emit(
      state.copyWith(
        isFiltering: (category != null && category != 'All') || shippingFilter != 'All',
        filteredProducts: result,
        sortBy: sortBy,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
        selectedShipping: shippingFilter,
      ),
    );
  }
}
