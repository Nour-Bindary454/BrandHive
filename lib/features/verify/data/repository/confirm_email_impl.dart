import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/verify/data/models/confirm_email_model.dart';
import 'package:brand/features/verify/data/repository/confirm_email_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ConfirmEmailRepoImpl implements ConfirmEmailRepository {
  final ApiService apiService;

  ConfirmEmailRepoImpl(this.apiService);

  @override
  Future<Either<Failure, String>> confirmEmail({
    required ConfirmEmailRequestModel request,
  }) async {
    try {
      final response = await apiService.postData(
        endPoint: EndPoints.confirmEmail,
        data: request.toJson(),
      );

      final message = response.data["message"];
      return right(message);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure("Unexpected error"));
    }
  }
}
