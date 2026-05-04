import 'package:brand/features/home/data/models/home_models.dart';

class HomeState {
  final bool isLoading;
  final String? error;

  final UserProfile? user;
  final BannerModel? banner;

  final List<CategoryModel> categories;
  final List<EventModel> events;
  final List<BrandModel> brands;
  final List<HomeProduct> recommended;
  final List<HomeProduct> featured;

  HomeState({
    this.isLoading = false,
    this.error,
    this.user,
    this.banner,
    this.categories = const [],
    this.events = const [],
    this.brands = const [],
    this.recommended = const [],
    this.featured = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    UserProfile? user,
    BannerModel? banner,
    List<CategoryModel>? categories,
    List<EventModel>? events,
    List<BrandModel>? brands,
    List<HomeProduct>? recommended,
    List<HomeProduct>? featured,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
      banner: banner ?? this.banner,
      categories: categories ?? this.categories,
      events: events ?? this.events,
      brands: brands ?? this.brands,
      recommended: recommended ?? this.recommended,
      featured: featured ?? this.featured,
    );
  }
}
