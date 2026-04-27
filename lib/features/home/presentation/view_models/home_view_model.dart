import 'package:flutter/material.dart';
import '../../data/models/home_models.dart';
import '../../data/repository/home_repo.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = true;
  String? _error;

  UserProfile? _userProfile;
  List<CategoryModel> _categories = [];
  List<EventModel> _events = [];
  BannerModel? _heroBanner;
  List<HomeBrand> _topBrands = [];
  List<HomeProduct> _recommendedProducts = [];
  List<HomeProduct> _featuredProducts = [];

  bool get isLoading => _isLoading;
  String? get error => _error;

  UserProfile? get userProfile => _userProfile;
  List<CategoryModel> get categories => _categories;
  List<EventModel> get events => _events;
  BannerModel? get heroBanner => _heroBanner;
  List<HomeBrand> get topBrands => _topBrands;
  List<HomeProduct> get recommendedProducts => _recommendedProducts;
  List<HomeProduct> get featuredProducts => _featuredProducts;

  Future<void> loadHomeData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API network delay
      await Future.delayed(const Duration(seconds: 2));

      // Dummy Data based on requirements
      _userProfile = UserProfile(
        name: 'Mustafa Kamal',
        profileImageUrl: 'https://i.pravatar.cc/150?img=11',
        greeting: 'Good Morning,',
      );

      _heroBanner = BannerModel(
        id: '1',
        label: 'New Arrival',
        title: 'Ramadan Collection',
        subtitle: 'Handcrafted Lanterns & Decor',
        imageUrl:
            'https://images.unsplash.com/photo-1596484552834-8a58f7eb21a2?q=80&w=1000&auto=format&fit=crop',
      );

      _categories = [
        CategoryModel(
          id: 'c1',
          name: 'Fashion',
          imageUrl:
              'https://images.unsplash.com/photo-1445205170230-053b83016050?q=80&w=300&auto=format&fit=crop',
        ),
        CategoryModel(
          id: 'c2',
          name: 'Home Decor',
          imageUrl:
              'https://images.unsplash.com/photo-1513694203232-719a280e022f?q=80&w=300&auto=format&fit=crop',
        ),
        CategoryModel(
          id: 'c3',
          name: 'Accessories',
          imageUrl:
              'https://images.unsplash.com/photo-1509319117193-57bab727e09d?q=80&w=300&auto=format&fit=crop',
        ),
        CategoryModel(
          id: 'c4',
          name: 'Beauty',
          imageUrl:
              'https://images.unsplash.com/photo-1596462502278-27bfdc403348?q=80&w=300&auto=format&fit=crop',
        ),
        CategoryModel(
          id: 'c5',
          name: 'Handicrafts',
          imageUrl:
              'https://images.unsplash.com/photo-1610471927806-69503dd2e2fb?q=80&w=300&auto=format&fit=crop',
        ),
      ];

      _events = [
        EventModel(
          id: 'e1',
          title: 'Cairo Artisan Bazaar',
          date: 'Dec 15-17',
          location: 'Khan El Khalili, Old Cairo',
        ),
        EventModel(
          id: 'e2',
          title: 'Winter Decor Market',
          date: 'Dec 20-22',
          location: 'Zamalek, Cairo',
        ),
      ];

      _topBrands = [
        HomeBrand(
          id: 'b1',
          name: 'Nile Weavers',
          category: 'Home Decor',
          coverImageUrl:
              'https://images.unsplash.com/photo-1513694203232-719a280e022f?q=80&w=300&auto=format&fit=crop',
          logoText: 'NW',
        ),
        HomeBrand(
          id: 'b2',
          name: 'Loyus Beauty',
          category: 'Beauty',
          coverImageUrl:
              'https://images.unsplash.com/photo-1615397323625-ed2366bfe0f8?q=80&w=300&auto=format&fit=crop',
          logoText: 'LB',
        ),
        HomeBrand(
          id: 'b3',
          name: 'Mare',
          category: 'Fashion',
          coverImageUrl:
              'https://images.unsplash.com/photo-1549298916-b41d501d3772?q=80&w=300&auto=format&fit=crop',
          logoText: 'MF',
        ),
      ];

      _recommendedProducts = [
        HomeProduct(
          id: 'rp1',
          brandName: 'PHARAONIC JEWELRY',
          category: 'Jewelry',
          name: 'Silver Ankh Necklace',
          imageUrl:
              'https://images.unsplash.com/photo-1596462502278-27bfdc403348?q=80&w=300&auto=format&fit=crop',
          price: 450,
          matchPercentage: 98,
        ),
        HomeProduct(
          id: 'rp2',
          brandName: 'CAIRO LEATHER',
          category: 'Fashion',
          name: 'Leather Tote Bag',
          imageUrl:
              'https://images.unsplash.com/photo-1584916201218-f4242ceb4809?q=80&w=300&auto=format&fit=crop',
          price: 1800,
          matchPercentage: 96,
        ),
        HomeProduct(
          id: 'rp3',
          brandName: 'TUNIS POTTERY',
          category: 'Home Decor',
          name: 'Ceramic Serving Bowl',
          imageUrl:
              'https://images.unsplash.com/photo-1610701596007-11502861dcfa?q=80&w=300&auto=format&fit=crop',
          price: 350,
          matchPercentage: 93,
        ),
      ];

      _featuredProducts = [
        HomeProduct(
          id: 'fp1',
          brandName: 'JELLAVU',
          category: 'Fashion',
          name: 'Straight Fit Jeans',
          imageUrl:
              'https://images.unsplash.com/photo-1542272605-e3666d6d84a7?q=80&w=400&auto=format&fit=crop',
          price: 900,
          rating: 4.8,
        ),
        HomeProduct(
          id: 'fp2',
          brandName: 'ECRU APPAREL',
          category: 'Fashion',
          name: 'Cotton Essential T-Shirt',
          imageUrl:
              'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=400&auto=format&fit=crop',
          price: 850,
          rating: 4.5,
        ),
        HomeProduct(
          id: 'fp3',
          brandName: 'FLUFFY COSMETICS',
          category: 'Beauty',
          name: 'Shiny Hydrating Lip Gloss',
          imageUrl:
              'https://images.unsplash.com/photo-1586495777744-4413f21062fa?q=80&w=400&auto=format&fit=crop',
          price: 650,
          rating: 4.3,
        ),
        HomeProduct(
          id: 'fp4',
          brandName: 'HANDMADE EGYPT',
          category: 'Fashion',
          name: 'HandMade Colorful dress',
          imageUrl:
              'https://images.unsplash.com/photo-1515347619362-e6e87f1ba28d?q=80&w=400&auto=format&fit=crop',
          price: 1400,
          rating: 4.9,
        ),
      ];
    } catch (e) {
      _error = 'Failed to load home data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
