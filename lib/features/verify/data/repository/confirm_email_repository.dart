import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/verify/data/models/confirm_email_model.dart';
import 'package:dartz/dartz.dart';

abstract class ConfirmEmailRepository {
  Future<Either<Failure, String>> confirmEmail({
    required ConfirmEmailRequestModel request,
  });
}
