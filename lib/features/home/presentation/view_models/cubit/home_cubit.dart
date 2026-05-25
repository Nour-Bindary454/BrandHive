import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/home/data/repository/home_repo.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand/core/services/cache_helper.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  Future<void> loadHomeData({bool isRefresh = false}) async {
    if (!isRefresh && state.brands.isNotEmpty && state.categories.isNotEmpty) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final hour = DateTime.now().hour;
      String greeting = 'Good Morning,';
      if (hour >= 12 && hour < 17) {
        greeting = 'Good Afternoon,';
      } else if (hour >= 17) {
        greeting = 'Good Evening,';
      }

      /// 1. USER
      final user = UserProfile(
        name: CacheHelper.getData(key: 'name') ?? 'User',
        profileImageUrl: 'https://i.pravatar.cc/150?img=11',
        greeting: greeting,
      );

      /// 2. BANNER
      final banner = BannerModel(
        id: '1',
        label: 'New Arrival',
        title: 'ramadan_collection'.tr(),
        subtitle: 'handcrafted_lanterns_decor'.tr(),
        imageUrl: 'https://placehold.co/1000x500/png',
      );

      /// 3. CATEGORIES (from API)
      List<CategoryModel> categories = [];
      final categoryResult = await sl<HomeRepository>().getAllCategories();
      categoryResult.fold(
        (failure) {
          print("Failed to load categories: ${failure.errMessage}");
        },
        (data) {
          categories = data;
        },
      );

      /// 4. EVENTS
      final events = [
        EventModel(
          id: 'e1',
          title: 'cairo_artisan_bazaar'.tr(),
          date: 'Dec 15-17',
          location: 'Khan El Khalili',
        ),
      ];

      /// 5. BRANDS — fetch all 5 pages IN PARALLEL
      List<BrandModel> allBrands = [];
      final brandResults = await Future.wait(
        List.generate(5, (i) => sl<HomeRepository>().getAllBrands(page: i + 1)),
      );
      for (final result in brandResults) {
        result.fold((failure) {}, (data) {
          allBrands.addAll(
            data.map(
              (e) => BrandModel(
                id: e.id,
                name: e.name,
                description: e.description,
                country: e.country,
                isActive: e.isActive,
                logoUrl: e.logoUrl,
                slug: e.slug,
              ),
            ),
          );
        });
      }

      /// 6. RECOMMENDED
      final recommended = [
        HomeProduct(
          id: 'rp1',
          brandName: 'PHARAONIC JEWELRY',
          category: 'Jewelry',
          name: 'Silver Necklace',
          imageUrl: 'https://placehold.co/300x300/png',
          price: 450,
          matchPercentage: 98,
        ),
      ];

      /// 7. FEATURED + CATEGORIES — fetch all 10 pages IN PARALLEL
      List<HomeProduct> featured = [];
      final productResults = await Future.wait(
        List.generate(10, (i) => sl<HomeRepository>().getAllProducts(page: i + 1)),
      );

      for (final result in productResults) {
        result.fold((failure) {}, (data) {
          featured.addAll(data);
        });
      }
      featured.shuffle(Random());

      /// ✅ FINAL EMIT
      emit(
        state.copyWith(
          isLoading: false,
          user: user,
          banner: banner,
          categories: categories,
          events: events,
          brands: allBrands,
          recommended: recommended,
          featured: featured,
        ),
      );

      /// 8. Load products for the first category if categories are not empty
      if (categories.isNotEmpty) {
        selectCategory(categories.first.id);
      }
    } catch (e) {
      print("🔥 ERROR: $e");
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> selectCategory(String categoryId) async {
    // Only update if it's a new category or we don't have products yet
    if (state.selectedCategoryId == categoryId && state.categoryProducts.isNotEmpty) return;

    emit(state.copyWith(
      selectedCategoryId: categoryId,
      isCategoryProductsLoading: true,
    ));

    final result = await sl<HomeRepository>().getProductsByCategory(categoryId);
    
    result.fold(
      (failure) {
        print("Failed to load category products: ${failure.errMessage}");
        emit(state.copyWith(isCategoryProductsLoading: false));
      },
      (products) {
        emit(state.copyWith(
          isCategoryProductsLoading: false,
          categoryProducts: products,
        ));
      },
    );
  }
  Future<void> updateProductStatus(String productId, bool isActive) async {
    final updatedFeatured = state.featured.map((p) {
      if (p.id == productId) return p.copyWith(isActive: isActive);
      return p;
    }).toList();

    emit(state.copyWith(featured: updatedFeatured));
  }

  Future<void> removeProduct(String productId) async {
    final updatedFeatured = state.featured.where((p) => p.id != productId).toList();
    emit(state.copyWith(featured: updatedFeatured));
  }

  Future<void> removeBrand(String brandId) async {
    final updatedBrands = state.brands.where((b) => b.id != brandId).toList();
    emit(state.copyWith(brands: updatedBrands));
  }

  Future<void> updateBrandStatus(String brandId, bool isActive) async {
    final updatedBrands = state.brands.map((b) {
      if (b.id == brandId) return b.copyWith(isActive: isActive);
      return b;
    }).toList();

    emit(state.copyWith(brands: updatedBrands));
  }
}
