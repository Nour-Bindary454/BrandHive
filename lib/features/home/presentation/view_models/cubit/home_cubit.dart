import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/home/data/repository/home_repo.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  Future<void> loadHomeData() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      /// 1. USER
      final user = UserProfile(
        name: 'Mustafa Kamal',
        profileImageUrl: 'https://i.pravatar.cc/150?img=11',
        greeting: 'Good Morning,',
      );

      /// 2. BANNER
      final banner = BannerModel(
        id: '1',
        label: 'New Arrival',
        title: 'ramadan_collection'.tr().tr(),
        subtitle: 'handcrafted_lanterns_decor'.tr().tr(),
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
          title: 'cairo_artisan_bazaar'.tr().tr(),
          date: 'Dec 15-17',
          location: 'Khan El Khalili',
        ),
      ];

      /// 5. BRANDS (API + fallback)
      List<BrandModel> allBrands = [];

      for (int i = 1; i <= 5; i++) {
        final result = await sl<HomeRepository>().getAllBrands(page: i);

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

      /// 6. RECOMMENDED (زي ViewModel)
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

      /// 7. FEATURED (API)
      List<HomeProduct> featured = [];
      final productsResult = await sl<HomeRepository>().getAllProducts(page: 1);
      productsResult.fold(
        (failure) {
          print("Failed to load products: ${failure.errMessage}");
          throw Exception(failure.errMessage);
        },
        (data) {
          featured = data;
        },
      );

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
    } catch (e) {
      print("🔥 ERROR: $e");
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
