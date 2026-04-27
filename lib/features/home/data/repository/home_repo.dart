import '../models/home_models.dart';

abstract class HomeRepository {
  Future<List<HomeProduct>> getProducts();
}
