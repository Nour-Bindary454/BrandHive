import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/forgetPassword/data/repository/verify_reset_code_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class VerifyResetCodeRepoImpl implements VerifyResetCodeRepository {
  final ApiService apiService;

  VerifyResetCodeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, String>> verifyResetCode({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.verifyresetcode,
        data: data,
      );

      final message = response.data["message"] ?? "Success";
      return right(message);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure("Unexpected error"));
    }
  }
}
