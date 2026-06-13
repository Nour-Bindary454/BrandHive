import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/explore/data/repository/explore_repo.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ApiService apiService;

  ExploreRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<HomeProduct>>> getAllProducts({
    int page = 1,
  }) async {
    try {
      final response = await apiService.getData(
        endPoint: "${EndPoints.products}?page=$page",
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
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (query.trim().isNotEmpty) {
        queryParams['search'] = query.trim();
      }
      if (categoryId != null && categoryId.isNotEmpty) {
        queryParams['category'] = categoryId;
      }
      if (brandId != null && brandId.isNotEmpty) {
        queryParams['brand'] = brandId;
      }
      if (minPrice != null) {
        queryParams['minPrice'] = minPrice;
      }
      if (maxPrice != null) {
        queryParams['maxPrice'] = maxPrice;
      }
      if (minRating != null) {
        queryParams['minRating'] = minRating;
      }
      if (inStock != null) {
        queryParams['inStock'] = inStock;
      }
      if (onSale != null) {
        queryParams['onSale'] = onSale;
      }
      if (shipsInternationally != null) {
        queryParams['shipsInternationally'] = shipsInternationally;
      }

      final response = await apiService.getData(
        endPoint: "search/products",
        query: queryParams.isNotEmpty ? queryParams : null,
      );

      final List<dynamic> data = response.data['data'] ?? response.data ?? [];
      final List<HomeProduct> products = data
          .map((p) => HomeProduct.fromJson(p))
          .toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
