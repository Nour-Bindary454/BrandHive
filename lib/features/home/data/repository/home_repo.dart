import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<BrandModel>>> getAllBrands({int page});
  Future<Either<Failure, List<HomeProduct>>> getAllProducts({int page = 1});
  Future<Either<Failure, List<HomeProduct>>> getProductsByCategory(String categoryId, {int page = 1});
  Future<Either<Failure, List<CategoryModel>>> getAllCategories();
  Future<Either<Failure, List<HomeProduct>>> getCategoryRecommendations(List<String> categories);
  Future<Either<Failure, List<HomeProduct>>> getBehavioralRecommendations(List<Map<String, dynamic>> interactions);
  Future<Either<Failure, List<Product>>> getCrossSellProducts(List<String> cartProductIds);
}
