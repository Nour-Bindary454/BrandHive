import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminRepositoryImpl implements AdminRepository {
  final ApiService apiService;

  AdminRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<AdminStatModel>>> getDashboardStats() async {
    try {
      int totalBrands = 0;
      int totalProducts = 0;
      int pendingRequests = 0;

      // ── BRANDS TOTAL ──────────────────────────────────────────────
      // Fetch page=1 limit=1 to read total from metadata without loading all data
      try {
        final resp = await apiService.getData(
          endPoint: "brand",
          query: {'page': '1', 'limit': '1'},
        );
        if (resp.data is Map) {
          final m = resp.data as Map;
          // Try all common total-count field names
          final raw =
              m['totalCount'] ??
              m['total'] ??
              m['count'] ??
              m['totalDocuments'] ??
              m['pagination']?['total'] ??
              m['pagination']?['totalCount'] ??
              m['meta']?['total'] ??
              m['meta']?['totalCount'];
          if (raw != null) {
            totalBrands = int.tryParse(raw.toString()) ?? 0;
          }
          // Fallback: if no metadata, sum all pages we can
          if (totalBrands == 0) {
            final List data = m['data'] ?? [];
            if (data.isNotEmpty) {
              // We don't know total, fetch more pages
              int page = 1;
              int found = 0;
              while (true) {
                try {
                  final pr = await apiService.getData(
                    endPoint: "brand",
                    query: {'page': page.toString()},
                  );
                  final List pageData = (pr.data is Map)
                      ? (pr.data['data'] ?? [])
                      : [];
                  if (pageData.isEmpty) break;
                  found += pageData.length;
                  page++;
                  if (page > 20) break; // safety cap
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
          final raw =
              m['totalCount'] ??
              m['total'] ??
              m['count'] ??
              m['totalDocuments'] ??
              m['pagination']?['total'] ??
              m['pagination']?['totalCount'] ??
              m['meta']?['total'] ??
              m['meta']?['totalCount'];
          if (raw != null) {
            totalProducts = int.tryParse(raw.toString()) ?? 0;
          }
          // Fallback: count from page=1 limit=100
          if (totalProducts == 0) {
            final fallback = await apiService.getData(
              endPoint: EndPoints.products,
              query: {'limit': '100'},
            );
            final List fd = (fallback.data is Map)
                ? (fallback.data['data'] ?? [])
                : [];
            totalProducts = fd.length;
          }
        }
      } catch (_) {}

      // ── PENDING BRAND REQUESTS ────────────────────────────────────
      try {
        final notifResp = await apiService.getData(
          endPoint: EndPoints.notifications,
        );
        if (notifResp.data is Map) {
          final List notifData = notifResp.data['data'] ?? [];
          pendingRequests = notifData.where((e) {
            final title = e['title']?.toString().toLowerCase() ?? '';
            final body = e['body']?.toString().toLowerCase() ?? '';
            final bId = e['data']?['brandId'];
            return title.contains('brand') ||
                body.contains('brand') ||
                bId != null;
          }).length;
        }
      } catch (_) {}

      return right([
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
      ]);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AdminBrandRequest>>> getBrandRequests() async {
    List<AdminBrandRequest> requests = [];
    List allBrands = [];

    // Fetch all brands (used for name-to-ID lookups in notifications fallback)
    try {
      final allResp = await apiService.getData(endPoint: "brand");
      if (allResp.data is Map) {
        allBrands = allResp.data['data'] ?? [];
      }
    } catch (_) {}

    // Try brand?status=pending (may return results if API supports this filter)
    try {
      final response = await apiService.getData(
        endPoint: "brand",
        query: {'status': 'pending'},
      );
      if (response.data is Map) {
        final List data = response.data['data'] ?? [];
        for (var e in data) {
          final id = e['_id'] ?? e['id'] ?? '';
          if (id.isNotEmpty && !requests.any((r) => r.id == id)) {
            requests.add(
              AdminBrandRequest(
                id: id,
                name: e['name'] ?? 'Unknown',
                location: e['country'] ?? 'Egypt',
                category: "Pending Approval",
                date: _formatDate(e['createdAt']),
                status: BrandStatus.pending,
              ),
            );
          }
        }
      }
    } catch (_) {}

    // Notifications — primary real source of new brand registration requests.
    // Uses notification._id as fallback brand ID if no explicit brandId in payload.
    try {
      final notifResponse = await apiService.getData(
        endPoint: EndPoints.notifications,
      );
      if (notifResponse.data is Map) {
        final List notifData = notifResponse.data['data'] ?? [];
        for (var e in notifData) {
          final String title = e['title']?.toString() ?? '';
          final String body = e['body']?.toString() ?? '';
          final payload = e['data'] ?? {};
          String? bId = payload['brandId'];
          String bName = payload['brandName'] ?? '';

          // Only process brand-related notifications
          if (!title.toLowerCase().contains('brand') &&
              !body.toLowerCase().contains('brand') &&
              bId == null)
            continue;

          if (bName.isEmpty) bName = title;

          // Try to match brand by name to get its real ID
          if (bId == null && bName.isNotEmpty) {
            try {
              final match = allBrands.firstWhere(
                (b) =>
                    b['name']?.toString().toLowerCase() == bName.toLowerCase(),
                orElse: () => null,
              );
              if (match != null) bId = match['_id'] ?? match['id'];
            } catch (_) {}
          }

          // Fallback: use the notification's own _id as the brand identifier
          bId ??= e['_id'];

          // Build the richest possible rawData from notification + matched brand
          final Map<String, dynamic> rawData = {
            ...Map<String, dynamic>.from(payload),
            'name': bName,
            'country': payload['country'] ?? 'Egypt',
          };

          // Merge full brand data if we found a match in allBrands
          if (bId != null) {
            try {
              final matched = allBrands.firstWhere(
                (b) => (b['_id'] ?? b['id']) == bId,
                orElse: () => null,
              );
              if (matched != null) {
                rawData.addAll(Map<String, dynamic>.from(matched));
              }
            } catch (_) {}
          }

          if (bId != null &&
              bId.isNotEmpty &&
              !requests.any((r) => r.id == bId)) {
            requests.add(
              AdminBrandRequest(
                id: bId,
                name: bName.isNotEmpty ? bName : 'New Brand Request',
                location: payload['country'] ?? 'Egypt',
                category: "Verification Pending",
                date: _formatDate(e['createdAt']),
                status: BrandStatus.pending,
                rawData: rawData,
              ),
            );
          }
        }
      }
    } catch (_) {}

    return right(requests);
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "Recent";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM d').format(date);
    } catch (e) {
      return "Recent";
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBrandStatus(
    String id,
    BrandStatus status,
  ) async {
    try {
      final action = status == BrandStatus.approved ? 'approve' : 'reject';
      await apiService.patchData(endPoint: "brand/requests/$id/$action");
      return right(unit);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await apiService.deleteData(endPoint: "${EndPoints.products}/$id");
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBrand(String id) async {
    try {
      await apiService.deleteData(endPoint: EndPoints.brandAction(id));
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleBrandStatus(
    String id,
    bool isActive,
  ) async {
    try {
      final endPoint = isActive
          ? EndPoints.deactivateBrand(id)
          : EndPoints.activateBrand(id);
      await apiService.patchData(endPoint: endPoint);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleProductStatus(
    String id,
    bool isActive,
  ) async {
    try {
      final action = isActive ? "deactivate" : "activate";
      await apiService.patchData(endPoint: "${EndPoints.products}/$id/$action");
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AdminOrderModel>>> getAllOrders() async {
    try {
      final response = await apiService.getData(
        endPoint: EndPoints.adminOrders,
      );
      final List data = response.data['data'];
      return right(data.map((e) => AdminOrderModel.fromJson(e)).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await apiService.getData(
        endPoint: EndPoints.notifications,
      );
      final List data = response.data['data'];
      return right(data.map((e) => NotificationModel.fromJson(e)).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
