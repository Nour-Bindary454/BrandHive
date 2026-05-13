import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:intl/intl.dart';

mixin AdminRequestsHelper {
  Future<List<CategoryModel>> fetchCategoriesList(ApiService apiService) async {
    final response = await apiService.getData(endPoint: EndPoints.categories);
    final List data = response.data is List
        ? response.data
        : (response.data['data'] ?? []);
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }

  Future<List<AdminBrandRequest>> fetchBrandRequestsList(
    ApiService apiService,
  ) async {
    List<AdminBrandRequest> requests = [];

    try {
      // Fetch up to 10 pages in parallel to ensure we get all requests
      final responses = await Future.wait(
        List.generate(10, (i) => apiService.getData(endPoint: "brand/requests?page=${i + 1}&limit=50"))
      );

      for (var response in responses) {
        dynamic rawData = response.data;
        List data = [];
        
        if (rawData is List) {
          data = rawData;
        } else if (rawData is Map) {
          data = rawData['data'] ?? rawData['requests'] ?? [];
        }

        if (data.isEmpty) continue;

        for (var e in data) {
          final id = e['_id'] ?? e['id'] ?? '';
          if (id.isNotEmpty) {
            requests.add(AdminBrandRequest(
              id: id,
              name: e['name'] ?? 'Unknown',
              location: e['country'] ?? 'Egypt',
              category: _extractCategoryName(e),
              date: formatDate(e['createdAt']),
              status: _mapStatus(e['status']),
              shipsInternationally: (e['shipsInternationally'] == true || 
                                     e['shipsInternationally'] == 1 || 
                                     e['shipsInternationally']?.toString() == 'true' || 
                                     e['shipsInternationally']?.toString() == '1' ||
                                     e['shipsInternationally']?.toString().toLowerCase() == 'yes') == true,
              rejectionReason: e['rejectionReason'],
              rawData: e,
            ));
          }
        }
      }
    } catch (_) {
      // Handle or log error
    }

    return requests;
  }

  String _extractCategoryName(Map<String, dynamic> e) {
    // Try to find populated categories first
    if (e['categories'] is List && e['categories'].isNotEmpty) {
      final first = e['categories'][0];
      if (first is Map) return first['name']?.toString() ?? 'Brand Request';
    }

    // Fallback to name if it's a single category field
    if (e['category'] is Map)
      return e['category']['name']?.toString() ?? 'Brand Request';
    if (e['category'] is String && e['category'].length > 10)
      return 'Brand Request'; // Probably an ID

    return e['category']?.toString() ?? 'Brand Request';
  }

  BrandStatus _mapStatus(String? status) {
    switch (status) {
      case 'approved':
        return BrandStatus.approved;
      case 'rejected':
        return BrandStatus.rejected;
      case 'pending':
      default:
        return BrandStatus.pending;
    }
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
