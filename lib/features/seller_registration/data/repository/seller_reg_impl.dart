import 'dart:io';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/seller_registration/data/model/category_model.dart';
import 'package:brand/features/seller_registration/data/model/seller_reg_model.dart';
import 'package:brand/features/seller_registration/data/repository/seller_reg_repo.dart';
import 'package:dio/dio.dart';

class BrandRequestRepoImpl implements BrandRequestRepo {
  final ApiService api;

  BrandRequestRepoImpl(this.api);

  @override
  Future<BrandRequestResponse> sendRequest(Map<String, dynamic> body) async {
    dynamic requestData = body;

    if (body.containsKey('logo') && body['logo'] is File) {
      final File logoFile = body['logo'];
      body['logo'] = await MultipartFile.fromFile(
        logoFile.path,
        filename: logoFile.path.split('/').last,
      );
      requestData = FormData.fromMap(body);
    }

    final response = await api.postData(
      endPoint: EndPoints.brandRequest,
      data: requestData,
    );
    return BrandRequestResponse.fromJson(response.data);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await api.getData(endPoint: EndPoints.categories);

    // الـ API بيرجع { data: [...] } أو list مباشرة
    final raw = response.data;
    List<dynamic> list;

    if (raw is List) {
      list = raw;
    } else if (raw is Map && raw['data'] != null) {
      list = raw['data'] as List;
    } else {
      list = [];
    }

    return list.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
