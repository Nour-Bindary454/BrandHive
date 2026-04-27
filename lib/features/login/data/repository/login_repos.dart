import 'package:dartz/dartz.dart';
import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/login/data/model/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> login({
    required Map<String, dynamic> data,
  });
}
