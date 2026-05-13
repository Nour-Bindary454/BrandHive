import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:flutter/material.dart';

mixin AdminStatsHelper {
  Future<List<AdminStatModel>> fetchDashboardStats(ApiService apiService) async {
    int totalBrands = 0;
    int totalProducts = 0;
    int pendingRequests = 0;

    // ── BRANDS TOTAL ──────────────────────────────────────────────
    try {
      final resp = await apiService.getData(
        endPoint: "brand",
        query: {'page': '1', 'limit': '1'},
      );
      if (resp.data is Map) {
        final m = resp.data as Map;
        final raw = m['totalCount'] ?? m['total'] ?? m['count'] ?? m['totalDocuments'] ??
            m['pagination']?['total'] ?? m['pagination']?['totalCount'] ??
            m['meta']?['total'] ?? m['meta']?['totalCount'];
        if (raw != null) {
          totalBrands = int.tryParse(raw.toString()) ?? 0;
        }
        if (totalBrands == 0) {
          final List data = m['data'] ?? [];
          if (data.isNotEmpty) {
            int page = 1;
            int found = 0;
            while (true) {
              try {
                final pr = await apiService.getData(
                  endPoint: "brand",
                  query: {'page': page.toString()},
                );
                final List pageData = (pr.data is Map) ? (pr.data['data'] ?? []) : [];
                if (pageData.isEmpty) break;
                found += pageData.length;
                page++;
                if (page > 20) break;
              } catch (_) {
                break;
              }
            }
            totalBrands = found;
          }
        }
      }
    } catch (_) {}

    // ── PRODUCTS TOTAL ────────────────────────────────────────────
    try {
      final resp = await apiService.getData(
        endPoint: EndPoints.products,
        query: {'page': '1', 'limit': '1'},
      );
      if (resp.data is Map) {
        final m = resp.data as Map;
        final raw = m['totalCount'] ?? m['total'] ?? m['count'] ?? m['totalDocuments'] ??
            m['pagination']?['total'] ?? m['pagination']?['totalCount'] ??
            m['meta']?['total'] ?? m['meta']?['totalCount'];
        if (raw != null) {
          totalProducts = int.tryParse(raw.toString()) ?? 0;
        }
        if (totalProducts == 0) {
          final fallback = await apiService.getData(
            endPoint: EndPoints.products,
            query: {'limit': '100'},
          );
          final List fd = (fallback.data is Map) ? (fallback.data['data'] ?? []) : [];
          totalProducts = fd.length;
        }
      }
    } catch (_) {}

    // ── PENDING BRAND REQUESTS ────────────────────────────────────
    try {
      final notifResp = await apiService.getData(endPoint: EndPoints.notifications);
      if (notifResp.data is Map) {
        final List notifData = notifResp.data['data'] ?? [];
        pendingRequests = notifData.where((e) {
          final title = e['title']?.toString().toLowerCase() ?? '';
          final body = e['body']?.toString().toLowerCase() ?? '';
          final bId = e['data']?['brandId'];
          return title.contains('brand') || body.contains('brand') || bId != null;
        }).length;
      }
    } catch (_) {}

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
}
