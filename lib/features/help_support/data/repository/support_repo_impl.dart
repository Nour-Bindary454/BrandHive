import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/help_support/data/model/support_response_model.dart';
import 'package:brand/features/help_support/data/repository/support_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SupportRepoImpl implements SupportRepository {
  final ApiService apiService;

  SupportRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SupportResponseModel>> sendSupportMessage({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.support,
        data: data,
      );
      final result = SupportResponseModel.fromJson(response.data);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure("Unexpected error occurred"));
    }
  }
}
