import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/help_support/data/model/support_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class SupportRepository {
  Future<Either<Failure, SupportResponseModel>> sendSupportMessage({
    required Map<String, dynamic> data,
  });
}
