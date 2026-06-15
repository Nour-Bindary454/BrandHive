import 'dart:convert';
import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/core/services/token_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class EventTracker {
  static final Dio _localDio = Dio(BaseOptions(
    baseUrl: EndPoints.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  static Future<void> track({
    required String productId,
    required String event,
  }) async {
    // Save to local cache for behavioral recommendations
    try {
      final cachedInteractionsStr = CacheHelper.getData(key: 'interactions');
      List<dynamic> interactions = [];
      if (cachedInteractionsStr != null && cachedInteractionsStr.isNotEmpty) {
        try {
          interactions = jsonDecode(cachedInteractionsStr);
        } catch (_) {
          interactions = [];
        }
      }
      
      final exists = interactions.any((i) => i is Map && i['product_id'] == productId && i['event'] == event);
      if (!exists) {
        interactions.add({
          'product_id': productId,
          'event': event,
        });
        await CacheHelper.saveData(key: 'interactions', value: jsonEncode(interactions));
      }
    } catch (e) {
      debugPrint("⚠️ [EventTracker] Failed to cache interaction locally: $e");
    }

    final userId = CacheHelper.getData(key: 'id');
    final role = CacheHelper.getData(key: 'role')?.toLowerCase();
    if (userId == null || userId.isEmpty || role == 'admin') {
      return;
    }
    try {
      final token = await TokenManager.getToken();
      final response = await _localDio.post(
        EndPoints.trackEvent,
        data: {
          'user_id': userId,
          'product_id': productId,
          'event': event,
        },
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            if (token != null && token.isNotEmpty) "Authorization": "Bearer $token",
          },
        ),
      );
      debugPrint(
        "✅ [EventTracker] Tracked event '$event' for product '$productId'. Response: ${response.data}",
      );
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        if (statusCode == 400 && responseData != null && (responseData['message'] == 'AI service error' || responseData.toString().contains('AI service error'))) {
          debugPrint(
            "⚠️ [EventTracker] Event '$event' was sent but is not fully supported by the backend AI recommendation service yet (returned 400 AI service error). This is a backend/AI server limitation.",
          );
          return;
        }
        debugPrint("❌ [EventTracker] Failed to track event '$event': ${e.message} (Response: ${e.response?.data})");
      } else {
        debugPrint("❌ [EventTracker] Failed to track event '$event': $e");
      }
    }
  }
}

