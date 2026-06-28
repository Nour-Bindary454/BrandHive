import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/forgetPassword/data/model/forget_password_model.dart';
import 'package:brand/features/forgetPassword/data/repository/forget_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ForgetPasswordRepoImpl implements ForgetPasswordRepository {
  final ApiService apiService;

  ForgetPasswordRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ForgetPasswordModel>> forgetPassword({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.forgetPassword,
        data: data,
      );

      return right(ForgetPasswordModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}
