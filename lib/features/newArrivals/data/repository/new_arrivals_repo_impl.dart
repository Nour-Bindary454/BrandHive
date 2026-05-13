import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/newArrivals/data/model/new_arrival_model.dart';
import 'package:brand/features/newArrivals/data/repository/new_arrivals_repo.dart';
import 'package:dartz/dartz.dart';

class NewArrivalsRepoImpl implements NewArrivalsRepo {
  final ApiService api;

  NewArrivalsRepoImpl(this.api);

  @override
  Future<Either<Failure, List<NewArrivalModel>>> getNewArrivals() async {
    try {
      final response = await api.getData(endPoint: EndPoints.newArrivals);

      final data = response.data['data'] as List;

      final products = data.map((e) => NewArrivalModel.fromJson(e)).toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
