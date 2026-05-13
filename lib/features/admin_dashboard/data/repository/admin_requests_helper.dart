import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:intl/intl.dart';

mixin AdminRequestsHelper {
  Future<List<AdminBrandRequest>> fetchBrandRequestsList(ApiService apiService) async {
    List<AdminBrandRequest> requests = [];
    List allBrands = [];

    try {
      final allResp = await apiService.getData(endPoint: "brand");
      if (allResp.data is Map) {
        allBrands = allResp.data['data'] ?? [];
      }
    } catch (_) {}

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
            requests.add(AdminBrandRequest(
              id: id,
              name: e['name'] ?? 'Unknown',
              location: e['country'] ?? 'Egypt',
              category: "Pending Approval",
              date: formatDate(e['createdAt']),
              status: BrandStatus.pending,
              rawData: e,
            ));
          }
        }
      }
    } catch (_) {}

    try {
      final notifResponse = await apiService.getData(endPoint: EndPoints.notifications);
      if (notifResponse.data is Map) {
        final List notifData = notifResponse.data['data'] ?? [];
        for (var e in notifData) {
          final String title = e['title']?.toString() ?? '';
          final String body = e['body']?.toString() ?? '';
          final payload = e['data'] ?? {};
          String? bId = payload['brandId'];
          String bName = payload['brandName'] ?? '';

          if (!title.toLowerCase().contains('brand') &&
              !body.toLowerCase().contains('brand') &&
              bId == null) continue;

          if (bName.isEmpty) bName = title;

          if (bId == null && bName.isNotEmpty) {
            try {
              final match = allBrands.firstWhere(
                (b) => b['name']?.toString().toLowerCase() == bName.toLowerCase(),
                orElse: () => null,
              );
              if (match != null) bId = match['_id'] ?? match['id'];
            } catch (_) {}
          }

          bId ??= e['_id'];

          final Map<String, dynamic> rawData = {
            ...Map<String, dynamic>.from(payload),
            'name': bName,
            'country': payload['country'] ?? 'Egypt',
          };

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

          if (bId != null && bId.isNotEmpty && !requests.any((r) => r.id == bId)) {
            requests.add(AdminBrandRequest(
              id: bId,
              name: bName.isNotEmpty ? bName : 'New Brand Request',
              location: payload['country'] ?? 'Egypt',
              category: "Verification Pending",
              date: formatDate(e['createdAt']),
              status: BrandStatus.pending,
              rawData: rawData,
            ));
          }
        }
      }
    } catch (_) {}

    return requests;
  }

  String formatDate(String? dateStr) {
    if (dateStr == null) return "Recent";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM d').format(date);
    } catch (e) {
      return "Recent";
    }
  }
}
