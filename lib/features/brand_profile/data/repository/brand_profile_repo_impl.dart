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
}
