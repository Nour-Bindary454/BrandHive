import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/signup/data/model/register_response_model.dart';
import 'package:brand/features/signup/data/repository/register_repos.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RegisterRepoImpl implements RegisterRepository {
  final ApiService? apiService;
  RegisterRepoImpl(this.apiService);

  @override
  @override
  Future<Either<Failure, RegisterModel>> register({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiService!.postData(
        endPoint: EndPoints.register,
        data: data,
      );

      final result = RegisterModel.fromJson(response.data);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure("Unexpected error"));
    }
  }
}
