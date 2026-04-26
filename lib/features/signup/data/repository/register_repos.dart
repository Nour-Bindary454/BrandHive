import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/signup/data/model/register_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterModel>> register({
    required Map<String, dynamic> data,
  });
}
