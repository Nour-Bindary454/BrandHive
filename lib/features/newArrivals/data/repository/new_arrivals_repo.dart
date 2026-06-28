import 'package:dartz/dartz.dart';
import 'package:brand/core/errors/failure.dart';
import '../model/new_arrival_model.dart';

abstract class NewArrivalsRepo {
  Future<Either<Failure, List<NewArrivalModel>>> getNewArrivals();
}
