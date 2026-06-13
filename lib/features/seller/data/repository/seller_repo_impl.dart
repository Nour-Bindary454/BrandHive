import 'dart:io';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/checkout/data/models/order_model.dart';
import 'package:brand/features/seller/data/model/seller_models.dart';
import 'package:brand/features/seller/data/repository/seller_repo.dart';
import 'package:dio/dio.dart';

class SellerRepositoryImpl implements SellerRepository {
  final ApiService _api;

  SellerRepositoryImpl(this._api);

  @override
  Future<SellerDashboardData> getDashboard() async {
    final response = await _api.getData(endPoint: EndPoints.sellerDashboard);
    final data = response.data['data'] ?? response.data;
    return SellerDashboardData.fromJson(data);
  }

  @override
  Future<List<SellerProductModel>> getProducts() async {
    final response = await _api.getData(endPoint: EndPoints.sellerProducts);
    final List<dynamic> list = response.data['data'] ?? response.data ?? [];
    return list.map((e) => SellerProductModel.fromJson(e)).toList();
  }

  @override
  Future<SellerProductModel> getProductDetails(String id) async {
    final response = await _api.getData(endPoint: EndPoints.sellerProductDetail(id));
    final data = response.data['data'] ?? response.data;
    return SellerProductModel.fromJson(data);
  }

  @override
  Future<SellerProductModel> createProduct(Map<String, dynamic> body) async {
    dynamic requestData = body;

    // Handle single image file upload
    if (body.containsKey('image') && body['image'] is File) {
      final File imgFile = body['image'];
      final multipartFile = await MultipartFile.fromFile(
        imgFile.path,
        filename: imgFile.path.split('/').last,
      );
      body['image'] = multipartFile;
      body['images'] = [
        await MultipartFile.fromFile(
          imgFile.path,
          filename: imgFile.path.split('/').last,
        )
      ];
      _prepareBodyForFormData(body);
      requestData = FormData.fromMap(body);
    } else if (body.containsKey('images') && body['images'] is List<File>) {
      // Support list of images if passed
      final List<File> files = body['images'];
      final List<MultipartFile> multipartFiles = [];
      for (var file in files) {
        multipartFiles.add(await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ));
      }
      body['images'] = multipartFiles;
      if (multipartFiles.isNotEmpty) {
        body['image'] = multipartFiles.first;
      }
      _prepareBodyForFormData(body);
      requestData = FormData.fromMap(body);
    }

    final response = await _api.postData(
      endPoint: EndPoints.sellerProducts,
      data: requestData,
    );
    final data = response.data['data'] ?? response.data;
    return SellerProductModel.fromJson(data);
  }

  @override
  Future<SellerProductModel> updateProduct(String id, Map<String, dynamic> body) async {
    dynamic requestData = body;

    // Handle single image file upload for updates
    if (body.containsKey('image') && body['image'] is File) {
      final File imgFile = body['image'];
      final multipartFile = await MultipartFile.fromFile(
        imgFile.path,
        filename: imgFile.path.split('/').last,
      );
      body['image'] = multipartFile;
      body['images'] = [
        await MultipartFile.fromFile(
          imgFile.path,
          filename: imgFile.path.split('/').last,
        )
      ];
      _prepareBodyForFormData(body);
      requestData = FormData.fromMap(body);
    } else if (body.containsKey('images') && body['images'] is List<File>) {
      final List<File> files = body['images'];
      final List<MultipartFile> multipartFiles = [];
      for (var file in files) {
        multipartFiles.add(await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ));
      }
      body['images'] = multipartFiles;
      if (multipartFiles.isNotEmpty) {
        body['image'] = multipartFiles.first;
      }
      _prepareBodyForFormData(body);
      requestData = FormData.fromMap(body);
    }

    final response = await _api.putData(
      endPoint: EndPoints.sellerProductDetail(id),
      data: requestData,
    );
    final data = response.data['data'] ?? response.data;
    return SellerProductModel.fromJson(data);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _api.deleteData(endPoint: EndPoints.sellerProductDetail(id));
  }

  @override
  Future<List<SellerInventoryAlert>> getStockAlerts() async {
    final response = await _api.getData(endPoint: EndPoints.sellerStockAlerts);
    final List<dynamic> list = response.data['data'] ?? response.data ?? [];
    return list.map((e) => SellerInventoryAlert.fromJson(e)).toList();
  }

  @override
  Future<void> adjustStock(String id, int quantity) async {
    // specified as a GET {{baseUrl}}/seller/inventory/:id/adjust
    // Let's pass the quantity as a query parameter
    await _api.getData(
      endPoint: EndPoints.sellerAdjustStock(id),
      query: {'quantity': quantity},
    );
  }

  @override
  Future<List<OrderModel>> getOrders({String? status}) async {
    final Map<String, dynamic> query = {};
    if (status != null && status.isNotEmpty) {
      query['status'] = status;
    }
    final response = await _api.getData(
      endPoint: EndPoints.sellerOrders,
      query: query,
    );
    final List<dynamic> list = response.data['data'] ?? response.data ?? [];
    return list.map((e) => OrderModel.fromJson(e)).toList();
  }

  @override
  Future<OrderModel> getOrderDetails(String id) async {
    final response = await _api.getData(endPoint: EndPoints.sellerOrderDetail(id));
    final data = response.data['data'] ?? response.data;
    return OrderModel.fromJson(data);
  }

  @override
  Future<SellerAnalyticsData> getAnalytics() async {
    final response = await _api.getData(endPoint: EndPoints.sellerAnalytics);
    final data = response.data['data'] ?? response.data;
    return SellerAnalyticsData.fromJson(data);
  }

  @override
  Future<List<SellerReviewModel>> getReviews() async {
    final response = await _api.getData(endPoint: EndPoints.sellerReviews);
    final List<dynamic> list = response.data['data'] ?? response.data ?? [];
    return list.map((e) => SellerReviewModel.fromJson(e)).toList();
  }

  void _prepareBodyForFormData(Map<String, dynamic> body) {
    if (body.containsKey('price') && body['price'] is double) {
      final double price = body['price'];
      if (price == price.toInt()) {
        body['price'] = price.toInt();
      }
    }
    if (body.containsKey('tags') && body['tags'] is List) {
      body['tags[]'] = body['tags'];
      body.remove('tags');
    }
  }
}
