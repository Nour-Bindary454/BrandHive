import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../data/models/bazaar_details_model.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/bazaar/domain/repository/bazaar_repository.dart';
import 'package:brand/features/bazaar/data/models/bazaar_model.dart';

class BazaarDetailsViewModel extends ChangeNotifier {
  BazaarDetailsModel? _bazaarDetails;
  bool _isLoading = false;
  String? _errorMessage;

  BazaarDetailsModel? get bazaarDetails => _bazaarDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetches the dynamic mock or API data based on the provided bazaar/event ID
  Future<void> fetchBazaarDetails(String bazaarId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 1. Try fetching from the real Repository if it's a real database ID
      BazaarModel? realBazaar;
      if (bazaarId.length == 24) {
        final result = await sl<BazaarRepository>().searchBazaars('');
        result.fold((_) {}, (list) {
          final found = list.where((element) => element.id == bazaarId);
          if (found.isNotEmpty) {
            realBazaar = found.first;
          }
        });
      }

      if (realBazaar != null) {
        _bazaarDetails = BazaarDetailsModel(
          id: realBazaar!.id,
          title: realBazaar!.name,
          description: realBazaar!.description,
          imageUrl:
              realBazaar!.imageUrl ??
              'https://images.unsplash.com/photo-1610701596007-11502861dcfa?q=80&w=300&auto=format&fit=crop',
          date: 'Dec 15-17',
          time: '10:00 AM - 10:00 PM',
          location: realBazaar!.address,
          phone: realBazaar!.contactInfo,
          whatsapp: realBazaar!.contactInfo,
          organizer: 'Organizer',
          additionalDetails: ['Free entry.'],
          upcomingDates: [
            UpcomingDateModel(
              id: 'd1',
              dateRange: 'Dec 15-17',
              fullDateString: 'Dec 15, 2025 - Dec 17, 2025',
              status: 'Scheduled',
            ),
          ],
          participatingBrands: [
            ParticipatingBrandModel(
              id: 'b1',
              name: 'Nile Weavers',
              isFeatured: true,
            ),
          ],
          eventHighlights: ['Special Discounts'],
        );
      } else {
        // Fallback to local mock data
        await Future.delayed(const Duration(milliseconds: 500));
        _bazaarDetails = BazaarDetailsModel(
          id: bazaarId,
          title: 'cairo_artisan_bazaar'.tr(),
          description:
              'The heart of Egyptian craftsmanship. Experience traditional bazaar vibes with modern local brands.',
          imageUrl:
              'https://images.unsplash.com/photo-1610701596007-11502861dcfa?q=80&w=300&auto=format&fit=crop',
          date: 'Dec 15-17',
          time: '10:00 AM - 10:00 PM',
          location:
              'Khan El Khalili, Old Cairo\nKhan El Khalili Market, Islamic Cairo, Cairo 11516',
          phone: '+20 100 123 4567',
          whatsapp: '+20 100 123 4567',
          organizer: 'Egyptian Ministry of Tourism',
          additionalDetails: [
            'Free entry for children under 12.',
            'Parking is available at the north entrance.',
          ],
          upcomingDates: [
            UpcomingDateModel(
              id: 'd1',
              dateRange: 'Dec 15-17',
              fullDateString: 'Dec 15, 2025 - Dec 17, 2025',
              status: 'Scheduled',
            ),
            UpcomingDateModel(
              id: 'd2',
              dateRange: 'Jan 19-21',
              fullDateString: 'Jan 19, 2026 - Jan 21, 2026',
              status: 'Scheduled',
            ),
          ],
          participatingBrands: [
            ParticipatingBrandModel(
              id: 'b1',
              name: 'Nile Weavers',
              isFeatured: true,
            ),
            ParticipatingBrandModel(
              id: 'b2',
              name: 'Tunis Pottery',
              isFeatured: true,
            ),
            ParticipatingBrandModel(
              id: 'b3',
              name: 'Cairo Leather',
              isFeatured: true,
            ),
          ],
          eventHighlights: [
            'Live Demonstrations',
            'Artisan Meet & Greet',
            'Special Discounts',
          ],
        );
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch details. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Launch external calls, URLs, or WhatsApp deeply (simulated here)
  void contactOrganizer(String method) {
    debugPrint('Opening $method link...');
  }
}
