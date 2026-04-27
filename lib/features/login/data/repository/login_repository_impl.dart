import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/login/data/model/login_model.dart';
import 'package:brand/features/login/data/repository/login_repos.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class LoginRepoImpl implements LoginRepository {
  final ApiService apiService;

  LoginRepoImpl(this.apiService);

  @override
  Future<Either<Failure, LoginModel>> login({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.login,
        data: data,
      );

      final result = LoginModel.fromJson(response.data);

      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure("Unexpected error"));
    }
  }
}
