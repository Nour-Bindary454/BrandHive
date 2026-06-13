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
    String? shipping,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      String? categoryId;
      if (category != null && category != 'All') {
        final cat = state.categories.firstWhere(
          (c) => c.name.toLowerCase() == category.toLowerCase(),
          orElse: () => CategoryModel(id: '', name: category, slug: ''),
        );
        if (cat.id.isNotEmpty) {
          categoryId = cat.id;
        }
      }

      double? minP = (minPrice != null && minPrice.isNotEmpty) ? double.tryParse(minPrice) : null;
      double? maxP = (maxPrice != null && maxPrice.isNotEmpty) ? double.tryParse(maxPrice) : null;

      bool? shipsInternationally;
      if (shipping == 'Global Only') {
        shipsInternationally = true;
      } else if (shipping == 'Egypt Only') {
        shipsInternationally = false;
      }

      final result = await repo.searchProducts(
        "",
        categoryId: categoryId,
        minPrice: minP,
        maxPrice: maxP,
        shipsInternationally: shipsInternationally,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, error: failure.errMessage));
        },
        (products) {
          List<HomeProduct> sortedList = List.from(products);
          if (sortBy != null) {
            if (sortBy == 'Price: Low') {
              sortedList.sort((a, b) => a.price.compareTo(b.price));
            } else if (sortBy == 'Price: High') {
              sortedList.sort((a, b) => b.price.compareTo(a.price));
            } else if (sortBy == 'Top Rated') {
              sortedList.sort((a, b) => b.rating.compareTo(a.rating));
            }
          }

          emit(
            state.copyWith(
              isLoading: false,
              isFiltering: (category != null && category != 'All') ||
                  (minPrice != null && minPrice.isNotEmpty) ||
                  (maxPrice != null && maxPrice.isNotEmpty) ||
                  (shipping != null && shipping != 'All'),
              filteredProducts: sortedList,
              sortBy: sortBy,
              category: category,
              minPrice: minPrice,
              maxPrice: maxPrice,
              shipping: shipping,
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
