import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';

import 'home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiService apiService;

  HomeRepositoryImpl(this.apiService);

  @override
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
}
