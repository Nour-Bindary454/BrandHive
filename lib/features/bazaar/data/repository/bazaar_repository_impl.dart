import 'dart:io';
import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/bazaar/data/models/bazaar_model.dart';
import 'package:brand/features/bazaar/domain/repository/bazaar_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BazaarRepositoryImpl implements BazaarRepository {
  final ApiService apiService;

  BazaarRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, BazaarModel>> getMyBazaar() async {
    try {
      final response = await apiService.getData(endPoint: EndPoints.myBazaar);
      final raw = response.data['data'] ?? response.data;
      if (raw == null) {
        return left(ServerFailure('Bazaar not found'));
      }
      return right(BazaarModel.fromJson(raw));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BazaarModel>> createBazaar(Map<String, dynamic> body) async {
    try {
      dynamic requestData = body;
      if (body.containsKey('logo') && body['logo'] is File) {
        final File logoFile = body['logo'];
        body['logo'] = await MultipartFile.fromFile(
          logoFile.path,
          filename: logoFile.path.split('/').last,
        );
      }
      if (body.containsKey('image') && body['image'] is File) {
        final File imgFile = body['image'];
        body['image'] = await MultipartFile.fromFile(
          imgFile.path,
          filename: imgFile.path.split('/').last,
        );
      }
      if (body.containsKey('logo') || body.containsKey('image')) {
        requestData = FormData.fromMap(body);
      }
      final response = await apiService.postData(
        endPoint: EndPoints.myBazaar,
        data: requestData,
      );
      final raw = response.data['data'] ?? response.data;
      return right(BazaarModel.fromJson(raw));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BazaarModel>> updateBazaar(Map<String, dynamic> body) async {
    try {
      dynamic requestData = body;
      if (body.containsKey('logo') && body['logo'] is File) {
        final File logoFile = body['logo'];
        body['logo'] = await MultipartFile.fromFile(
          logoFile.path,
          filename: logoFile.path.split('/').last,
        );
      }
      if (body.containsKey('image') && body['image'] is File) {
        final File imgFile = body['image'];
        body['image'] = await MultipartFile.fromFile(
          imgFile.path,
          filename: imgFile.path.split('/').last,
        );
      }
      if (body.containsKey('logo') || body.containsKey('image')) {
        requestData = FormData.fromMap(body);
      }
      final response = await apiService.putData(
        endPoint: EndPoints.myBazaar,
        data: requestData,
      );
      final raw = response.data['data'] ?? response.data;
      return right(BazaarModel.fromJson(raw));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BazaarModel>>> getAllBazaars({int page = 1, int limit = 10}) async {
    try {
      final response = await apiService.getData(
        endPoint: "${EndPoints.adminAllBazaars}?page=$page&limit=$limit",
      );
      final rawData = response.data['data'] ?? response.data;
      List<dynamic> list = [];
      if (rawData is List) {
        list = rawData;
      } else if (rawData is Map) {
        list = [rawData];
      }
      final bazaars = list.map((e) => BazaarModel.fromJson(e)).toList();
      return right(bazaars);
    } catch (e) {
      // Fallback 1: If GET fails, try PUT
      try {
        final response = await apiService.putData(
          endPoint: "${EndPoints.adminAllBazaars}?page=$page&limit=$limit",
        );
        final rawData = response.data['data'] ?? response.data;
        List<dynamic> list = [];
        if (rawData is List) {
          list = rawData;
        } else if (rawData is Map) {
          list = [rawData];
        }
        final bazaars = list.map((e) => BazaarModel.fromJson(e)).toList();
        return right(bazaars);
      } catch (e2) {
        // Fallback 2: If admin endpoint is forbidden/fails (e.g. customer user), fetch public bazaars via search
        try {
          final response = await apiService.getData(
            endPoint: EndPoints.searchBazaars,
            query: {'search': ''},
          );
          final List<dynamic> list = response.data['data'] ?? response.data ?? [];
          final bazaars = list.map((e) => BazaarModel.fromJson(e)).toList();
          return right(bazaars);
        } catch (e3) {
          return left(ServerFailure(e3.toString()));
        }
      }
    }
  }

  @override
  Future<Either<Failure, List<BazaarModel>>> searchBazaars(String query) async {
    try {
      final response = await apiService.getData(
        endPoint: EndPoints.searchBazaars,
        query: {'search': query},
      );
      final List<dynamic> list = response.data['data'] ?? response.data ?? [];
      final bazaars = list.map((e) => BazaarModel.fromJson(e)).toList();
      return right(bazaars);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> notifyFollowers(String title, String body) async {
    try {
      await apiService.postData(
        endPoint: EndPoints.notifyFollowers,
        data: {
          'title': title,
          'body': body,
        },
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleBazaarStatus(String id) async {
    try {
      await apiService.patchData(
        endPoint: EndPoints.toggleBazaar(id),
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reviewBazaar(String sellerId, String status, {String? rejectionReason}) async {
    try {
      await apiService.patchData(
        endPoint: "seller/bazaar/admin/$sellerId/review",
        data: {
          'status': status,
          if (rejectionReason != null) 'rejectionReason': rejectionReason,
        },
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
