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
  Future<Either<Failure, List<HomeProduct>>> searchProducts(String query) async {
    try {
      final response = await apiService.getData(
        endPoint: "search/products?search=$query",
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
}
