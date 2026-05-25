import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:flutter/material.dart';

mixin AdminStatsHelper {
  Future<List<AdminStatModel>> fetchDashboardStats(ApiService apiService) async {
    int totalBrands = await _fetchTotalBrands(apiService);
    int totalProducts = await _fetchTotalProducts(apiService);
    int pendingRequests = await _fetchPendingRequests(apiService);

    return [
      AdminStatModel(
        value: pendingRequests.toString(),
        label: "Pending",
        subtitle: "Brand requests",
        icon: Icons.hourglass_empty_rounded,
        color: const Color(0xFF2D4373),
      ),
      AdminStatModel(
        value: totalProducts > 999
            ? "${(totalProducts / 1000).toStringAsFixed(1)}K"
            : totalProducts.toString(),
        label: "Products",
        subtitle: "Total listed",
        icon: Icons.inventory_2_outlined,
        color: const Color(0xFF2D4373),
      ),
      AdminStatModel(
        value: "—",
        label: "Revenue EGP",
        subtitle: "Not available",
        icon: Icons.attach_money_rounded,
        color: const Color(0xFF2D4373),
      ),
      AdminStatModel(
        value: totalBrands.toString(),
        label: "Total Brands",
        subtitle: "Registered brands",
        icon: Icons.grid_view_rounded,
        color: const Color(0xFF2D4373),
      ),
    ];
  }

  Future<int> _fetchTotalBrands(ApiService apiService) async {
    try {
      final resp = await apiService.getData(
        endPoint: "brand",
        query: {'page': '1', 'limit': '1'},
      );
      if (resp.data is Map) {
        final m = resp.data as Map;
        final raw = m['meta']?['total'] ?? m['totalCount'] ?? m['total'] ?? 0;
        return int.tryParse(raw.toString()) ?? 0;
      }
    } catch (_) {}
    return 0;
  }

  Future<int> _fetchTotalProducts(ApiService apiService) async {
    try {
      final resp = await apiService.getData(
        endPoint: EndPoints.products,
        query: {'page': '1', 'limit': '1'},
      );
      if (resp.data is Map) {
        final m = resp.data as Map;
        final raw = m['meta']?['total'] ?? m['totalCount'] ?? m['total'] ?? 0;
        return int.tryParse(raw.toString()) ?? 0;
      }
    } catch (_) {}
    return 0;
  }

  Future<int> _fetchPendingRequests(ApiService apiService) async {
    try {
      final resp = await apiService.getData(
        endPoint: "brand/requests",
        query: {'page': '1', 'limit': '1'},
      );
      if (resp.data is Map) {
        final m = resp.data as Map;
        final raw = m['meta']?['total'] ?? m['total'] ?? 0;
        return int.tryParse(raw.toString()) ?? 0;
      }
    } catch (_) {}
    return 0;
  }
}
