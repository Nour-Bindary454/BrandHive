import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';
import 'package:brand/core/errors/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<BrandModel>>> getAllBrands({int page});
}
