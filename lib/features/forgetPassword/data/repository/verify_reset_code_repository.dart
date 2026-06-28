import 'package:brand/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class VerifyResetCodeRepository {
  Future<Either<Failure, String>> verifyResetCode({
    required Map<String, dynamic> data,
  });
}
