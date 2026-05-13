import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/brand_profile/data/repository/brand_profile_repo.dart';
import 'package:dartz/dartz.dart';

class BrandProfileRepositoryImpl implements BrandProfileRepository {
  final ApiService apiService;

  BrandProfileRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<HomeProduct>>> getBrandProducts(String brandId) async {
    try {
      final response = await apiService.getData(
        endPoint: "${EndPoints.products}?brand=$brandId&limit=100",
      );

      final List<dynamic> data = response.data['data'] ?? [];
      final List<HomeProduct> products = data.map((json) => HomeProduct.fromJson(json)).toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BrandModel>> getBrandById(String brandId) async {
    // 1. Try direct brand detail endpoint
    try {
      final response = await apiService.getData(endPoint: "brand/$brandId");
      final data = response.data['data'];
      if (data != null) {
        return right(BrandModel.fromJson(data is List ? data.first : data));
      }
    } catch (_) {}

    // 2. Try get-one with query param
    try {
      final response = await apiService.getData(
        endPoint: "brand/get-one",
        query: {'id': brandId},
      );
      final data = response.data['data'];
      if (data != null) {
        return right(BrandModel.fromJson(data is List ? data.first : data));
      }
    } catch (_) {}

    // 3. Try brand/request direct detail
    try {
      final response = await apiService.getData(endPoint: "brand/request/$brandId");
      final data = response.data['data'];
      if (data != null) {
        return right(BrandModel.fromJson(data is List ? data.first : data));
      }
    } catch (_) {}

    // 4. Try searching in full brand list
    try {
      final response = await apiService.getData(endPoint: "brand");
      final List brands = response.data['data'] ?? [];
      final match = brands.firstWhere(
        (b) => b['_id'] == brandId || b['id'] == brandId,
        orElse: () => throw Exception("Not in brand list"),
      );
      return right(BrandModel.fromJson(match));
    } catch (_) {
      // 5. Try searching in full brand/request list
      try {
        final response = await apiService.getData(endPoint: "brand/request");
        final List requests = response.data['data'] ?? [];
        final match = requests.firstWhere(
          (b) => b['_id'] == brandId || b['id'] == brandId,
          orElse: () => throw Exception("Brand ID $brandId not found in any system list"),
        );
        return right(BrandModel.fromJson(match));
      } catch (e) {
        return left(ServerFailure(
            "Failed to fetch brand details: ${e.toString().contains('not found') ? e.toString() : 'Invalid brand data'}"));
      }
    }
  }
}
