import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';

abstract class BrandProfileRepository {
  Future<Either<Failure, List<HomeProduct>>> getBrandProducts(String brandId);
}
