import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/bazaar/data/models/bazaar_model.dart';
import 'package:dartz/dartz.dart';

abstract class BazaarRepository {
  Future<Either<Failure, BazaarModel>> getMyBazaar();
  Future<Either<Failure, BazaarModel>> updateBazaar(Map<String, dynamic> body);
  Future<Either<Failure, List<BazaarModel>>> getAllBazaars({int page = 1, int limit = 10});
  Future<Either<Failure, List<BazaarModel>>> searchBazaars(String query);
  Future<Either<Failure, void>> notifyFollowers(String title, String body);
  Future<Either<Failure, void>> toggleBazaarStatus(String id);
}
