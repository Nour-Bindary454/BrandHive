import 'dart:convert';
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

      /// 2. CATEGORIES (from API)
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

      /// 6. FEATURED + CATEGORIES — fetch all 10 pages IN PARALLEL
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

      /// 7. RECOMMENDED - Dynamic based on interaction cache
      List<HomeProduct> recommended = [];
      final interactionsStr = CacheHelper.getData(key: 'interactions');
      List<Map<String, dynamic>> interactions = [];
      if (interactionsStr != null && interactionsStr.isNotEmpty) {
        try {
          final decoded = jsonDecode(interactionsStr);
          if (decoded is List) {
            interactions = decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
          }
        } catch (e) {
          print("Failed to decode interactions: $e");
        }
      }

      if (interactions.isNotEmpty) {
        final recResult = await sl<HomeRepository>().getBehavioralRecommendations(interactions);
        recResult.fold(
          (failure) {
            print("Failed to load behavioral recommendations: ${failure.errMessage}");
          },
          (data) {
            recommended = data;
          },
        );
      } else {
        final prefCategoriesStr = CacheHelper.getData(key: 'pref_categories');
        List<String> prefCategories = [];
        if (prefCategoriesStr != null && prefCategoriesStr.isNotEmpty) {
          try {
            final decoded = jsonDecode(prefCategoriesStr);
            if (decoded is List) {
              prefCategories = List<String>.from(decoded);
            }
          } catch (e) {
            print("Failed to decode preferred categories: $e");
          }
        }
        
        if (prefCategories.isEmpty) {
          prefCategories = ['Accessories'];
        }
        
        final recResult = await sl<HomeRepository>().getCategoryRecommendations(prefCategories);
        recResult.fold(
          (failure) {
            print("Failed to load category recommendations: ${failure.errMessage}");
          },
          (data) {
            recommended = data;
          },
        );
      }

      // Map virtual recommended products to real database products of the same category
      final List<HomeProduct> mappedRecommended = [];
      final Set<String> usedDbProductIds = {};

      if (recommended.isNotEmpty) {
        for (final recProd in recommended) {
          // 1. Try to find strict ID match in database
          final exactMatch = featured.firstWhere(
            (p) => p.id == recProd.id,
            orElse: () => HomeProduct(id: '', brandName: '', category: '', name: '', imageUrl: '', price: 0.0),
          );
          
          if (exactMatch.id.isNotEmpty) {
            mappedRecommended.add(exactMatch.copyWith(
              matchPercentage: recProd.matchPercentage > 0 ? recProd.matchPercentage : 95,
            ));
            usedDbProductIds.add(exactMatch.id);
            continue;
          }

          // 2. Try to find a database product of the same category that hasn't been used yet
          final recCatLower = recProd.category.toLowerCase().trim();
          final catMatch = featured.firstWhere(
            (p) => p.category.toLowerCase().trim() == recCatLower && !usedDbProductIds.contains(p.id),
            orElse: () => HomeProduct(id: '', brandName: '', category: '', name: '', imageUrl: '', price: 0.0),
          );

          if (catMatch.id.isNotEmpty) {
            mappedRecommended.add(catMatch.copyWith(
              matchPercentage: recProd.matchPercentage > 0 ? recProd.matchPercentage : 95,
            ));
            usedDbProductIds.add(catMatch.id);
            continue;
          }

          // 3. Fallback: if no same-category products are available, find any unused database product
          final anyMatch = featured.firstWhere(
            (p) => !usedDbProductIds.contains(p.id),
            orElse: () => HomeProduct(id: '', brandName: '', category: '', name: '', imageUrl: '', price: 0.0),
          );

          if (anyMatch.id.isNotEmpty) {
            mappedRecommended.add(anyMatch.copyWith(
              matchPercentage: recProd.matchPercentage > 0 ? recProd.matchPercentage : 95,
            ));
            usedDbProductIds.add(anyMatch.id);
          }
        }
      }

      // Apply brand diversity filtering to ensure mixed brands are shown
      recommended = _ensureBrandDiversity(mappedRecommended);

      /// ✅ FINAL EMIT
      emit(
        state.copyWith(
          isLoading: false,
          user: user,
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

  List<HomeProduct> _ensureBrandDiversity(List<HomeProduct> products) {
    if (products.isEmpty) return products;

    // Group by brand to interleave them nicely
    final Map<String, List<HomeProduct>> brandGroups = {};
    for (final p in products) {
      final brand = p.brandName.trim().toLowerCase();
      brandGroups.putIfAbsent(brand, () => []).add(p);
    }

    final List<HomeProduct> result = [];
    bool added = true;
    while (added) {
      added = false;
      for (final brand in brandGroups.keys) {
        final list = brandGroups[brand]!;
        if (list.isNotEmpty) {
          result.add(list.removeAt(0));
          added = true;
        }
      }
    }
    return result;
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
