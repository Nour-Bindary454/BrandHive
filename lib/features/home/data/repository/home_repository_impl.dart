import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';

import 'home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiService apiService;

  HomeRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<BrandModel>>> getAllBrands({int page = 1}) async {
    try {
      final response = await apiService.getData(
        endPoint: "${EndPoints.getall}?page=$page",
      );

      final List<dynamic> data = response.data['data'] ?? [];
      final List<BrandModel> brands = data
          .map((b) => BrandModel.fromJson(b))
          .toList();

      return right(brands);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      final response = await apiService.getData(endPoint: EndPoints.categories);

      final List<dynamic> data = response.data['data'] ?? [];
      final List<CategoryModel> categories = data
          .map((c) => CategoryModel.fromJson(c))
          .toList();

      return right(categories);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeProduct>>> getAllProducts({
    int page = 1,
  }) async {
    try {
      final response = await apiService.getData(
        endPoint: "${EndPoints.products}?page=$page&limit=100",
      );

      final List<dynamic> data = response.data['data'] ?? [];
      final List<HomeProduct> products = data
          .map((p) => HomeProduct.fromJson(p))
          .toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeProduct>>> getProductsByCategory(
      String categoryId, {
      int page = 1,
  }) async {
    try {
      final response = await apiService.getData(
        endPoint: "${EndPoints.products}?category=$categoryId&page=$page&limit=100",
      );

      final List<dynamic> data = response.data['data'] ?? [];
      final List<HomeProduct> products = data
          .map((p) => HomeProduct.fromJson(p))
          .toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeProduct>>> getCategoryRecommendations(List<String> categories) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.productRecommendations,
        data: {
          "categories": categories,
        },
      );
      final List<dynamic> productsData = response.data['products'] ?? [];
      final List<HomeProduct> products = productsData.map((p) {
        final id = p['id'] ?? p['_id'] ?? '';
        final brandName = p['brand_name'] ?? (p['brand'] is Map ? (p['brand']['name'] ?? '') : (p['brand']?.toString() ?? ''));
        final category = p['category_name'] ?? (p['category'] is Map ? (p['category']['name'] ?? '') : (p['category']?.toString() ?? ''));
        final name = p['name'] ?? '';
        final description = p['description'] ?? '';
        
        final priceVal = p['finalPrice'] ?? p['discountPrice'] ?? p['price'] ?? 0.0;
        final double price = double.tryParse(priceVal.toString()) ?? 0.0;

        final double rawScore = double.tryParse((p['score'] ?? p['match_score'] ?? 0.0).toString()) ?? 0.0;
        int matchPercentage = (rawScore <= 1.0 && rawScore > 0.0) ? (rawScore * 100).round() : rawScore.round();
        if (matchPercentage == 0) matchPercentage = 95;

        final ratingVal = p['stats_averageRating'] ?? (p['stats'] is Map ? (p['stats']['averageRating'] ?? 0.0) : 0.0);
        final double rating = double.tryParse(ratingVal.toString()) ?? 0.0;

        String imageUrl = '';
        final catLower = category.toString().toLowerCase();
        if (catLower.contains('accessories')) {
          imageUrl = "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=400";
        } else if (catLower.contains('beauty')) {
          imageUrl = "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=400";
        } else if (catLower.contains('fashion')) {
          imageUrl = "https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=400";
        } else if (catLower.contains('home decor') || catLower.contains('decor')) {
          imageUrl = "https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=400";
        } else if (catLower.contains('handicraft')) {
          imageUrl = "https://images.unsplash.com/photo-1513519245088-0e12902e5a38?q=80&w=400";
        } else {
          imageUrl = "https://images.unsplash.com/photo-1523381210434-271e8be1f52b?q=80&w=400";
        }

        return HomeProduct(
          id: id,
          brandName: brandName,
          category: category,
          name: name,
          description: description,
          imageUrl: imageUrl,
          price: price,
          matchPercentage: matchPercentage,
          rating: rating,
          isActive: true,
        );
      }).toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeProduct>>> getBehavioralRecommendations(List<Map<String, dynamic>> interactions) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.behavioralRecommend,
        data: {
          "interactions": interactions,
        },
      );
      final List<dynamic> productsData = response.data['recommendations'] ?? [];
      final List<HomeProduct> products = productsData.map((p) {
        final id = p['id'] ?? p['_id'] ?? '';
        final brandName = p['brand_name'] ?? (p['brand'] is Map ? (p['brand']['name'] ?? '') : (p['brand']?.toString() ?? ''));
        final category = p['category_name'] ?? (p['category'] is Map ? (p['category']['name'] ?? '') : (p['category']?.toString() ?? ''));
        final name = p['name'] ?? '';
        final description = p['description'] ?? '';
        
        final priceVal = p['finalPrice'] ?? p['discountPrice'] ?? p['price'] ?? 0.0;
        final double price = double.tryParse(priceVal.toString()) ?? 0.0;

        final double rawScore = double.tryParse((p['score'] ?? p['match_score'] ?? 0.0).toString()) ?? 0.0;
        int matchPercentage = (rawScore <= 1.0 && rawScore > 0.0) ? (rawScore * 100).round() : rawScore.round();
        if (matchPercentage == 0) matchPercentage = 95;

        final ratingVal = p['stats_averageRating'] ?? (p['stats'] is Map ? (p['stats']['averageRating'] ?? 0.0) : 0.0);
        final double rating = double.tryParse(ratingVal.toString()) ?? 0.0;

        String imageUrl = '';
        final catLower = category.toString().toLowerCase();
        if (catLower.contains('accessories')) {
          imageUrl = "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=400";
        } else if (catLower.contains('beauty')) {
          imageUrl = "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=400";
        } else if (catLower.contains('fashion')) {
          imageUrl = "https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=400";
        } else if (catLower.contains('home decor') || catLower.contains('decor')) {
          imageUrl = "https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=400";
        } else if (catLower.contains('handicraft')) {
          imageUrl = "https://images.unsplash.com/photo-1513519245088-0e12902e5a38?q=80&w=400";
        } else {
          imageUrl = "https://images.unsplash.com/photo-1523381210434-271e8be1f52b?q=80&w=400";
        }

        return HomeProduct(
          id: id,
          brandName: brandName,
          category: category,
          name: name,
          description: description,
          imageUrl: imageUrl,
          price: price,
          matchPercentage: matchPercentage,
          rating: rating,
          isActive: true,
        );
      }).toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCrossSellProducts(
    List<String> cartProductIds,
  ) async {
    if (cartProductIds.isEmpty) {
      return right([]);
    }

    try {
      final response = await apiService.postData(
        endPoint: EndPoints.cartCrossSell,
        data: {
          'cart_product_ids': cartProductIds,
        },
      );

      final List<dynamic> productsData = response.data['products'] ?? [];
      final products = productsData.map((p) {
        final product = Product.fromJson(p);
        if (product.image.isNotEmpty &&
            !product.image.contains('placehold.co')) {
          return product;
        }

        final category = (p['category_name'] ?? p['category'] ?? '')
            .toString()
            .toLowerCase();
        return Product(
          id: product.id,
          brandId: product.brandId,
          brandName: product.brandName,
          name: product.name,
          description: product.description,
          image: _categoryPlaceholderImage(category),
          rating: product.rating,
          price: product.price,
          currency: product.currency,
          isFavorite: product.isFavorite,
          isActive: product.isActive,
        );
      }).toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  String _categoryPlaceholderImage(String category) {
    final catLower = category.toLowerCase();
    if (catLower.contains('accessories')) {
      return 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=400';
    }
    if (catLower.contains('beauty')) {
      return 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=400';
    }
    if (catLower.contains('fashion')) {
      return 'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=400';
    }
    if (catLower.contains('home decor') || catLower.contains('decor')) {
      return 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=400';
    }
    if (catLower.contains('handicraft')) {
      return 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?q=80&w=400';
    }
    return 'https://placehold.co/300x300/png';
  }
}
