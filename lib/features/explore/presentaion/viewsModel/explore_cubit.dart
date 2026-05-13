import 'package:brand/core/services/service_locator.dart';
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
  }) async {
    List<HomeProduct> result;

    // If a specific category is selected, fetch from API by category ID
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
        isFiltering: category != null && category != 'All',
        filteredProducts: result,
        sortBy: sortBy,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    );
  }
}
