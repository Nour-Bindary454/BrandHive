import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/core/services/token_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = EndPoints.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    // Attach interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add default headers

          options.headers["Accept"] = "application/json";

          final token = TokenManager.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          debugPrint("➡️ [REQUEST] ${options.method} ${options.uri}");
          debugPrint("Headers: ${options.headers}");
          debugPrint("Data: ${options.data}");
          debugPrint("Query: ${options.queryParameters}");

          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          debugPrint(
            "✅ [RESPONSE] [${response.statusCode}] ${response.requestOptions.uri}",
          );
          debugPrint("Response Data: ${response.data}");
          return handler.next(response); // continue
        },
        onError: (DioException error, handler) async {
          debugPrint("❌ [ERROR] ${error.message}");
          debugPrint("Request: ${error.requestOptions.uri}");
          // Example: handle token expiration (401 Unauthorized)
          final failure = ServerFailure.fromDioError(error);
          debugPrint("❌ [ERROR] ${failure.errMessage}");
          return handler.reject(error.copyWith(error: failure));
        },
      ),
    );
  }

  // Now no need to manually add headers everywhere
  Future<Response> postData({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? query,
    bool isMultipart = false,
  }) async {
    return await _dio.post(endPoint, data: data, queryParameters: query);
  }

  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(endPoint, queryParameters: query);
  }

  Future<Response> putData({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.put(endPoint, data: data, queryParameters: query);
  }

  Future<Response> patchData({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.patch(endPoint, data: data, queryParameters: query);
  }

  Future<Response> deleteData({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.delete(endPoint, data: data, queryParameters: query);
  }
}
