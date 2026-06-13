import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';

abstract class ExploreRepository {
  Future<Either<Failure, List<HomeProduct>>> getAllProducts({int page = 1});
  Future<Either<Failure, List<HomeProduct>>> searchProducts(
    String query, {
    String? categoryId,
    String? brandId,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool? inStock,
    bool? onSale,
    bool? shipsInternationally,
  });
}
