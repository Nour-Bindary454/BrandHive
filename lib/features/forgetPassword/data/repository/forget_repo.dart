import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/forgetPassword/data/model/forget_password_model.dart';
import 'package:dartz/dartz.dart';

abstract class ForgetPasswordRepository {
  Future<Either<Failure, ForgetPasswordModel>> forgetPassword({
    required Map<String, dynamic> data,
  });
}
