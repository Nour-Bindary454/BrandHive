import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';

abstract class ExploreRepository {
  Future<Either<Failure, List<HomeProduct>>> getAllProducts({int page = 1});
  Future<Either<Failure, List<HomeProduct>>> searchProducts(
    String query, {
<<<<<<< HEAD
    String? categoryId,
    String? brandId,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool? inStock,
    bool? onSale,
    bool? shipsInternationally,
  });
=======
    bool? shipsInternationally,
  });
  Future<Either<Failure, List<Product>>> getTrendingProducts();
>>>>>>> b638b3040374aa6e62f93d89ede990324fbda31e
}

