import 'package:brand/features/seller_registration/data/model/category_model.dart';
import 'package:brand/features/seller_registration/data/model/seller_reg_model.dart';

abstract class BrandRequestRepo {
  Future<BrandRequestResponse> sendRequest(Map<String, dynamic> body);
  Future<List<CategoryModel>> getCategories();
}
