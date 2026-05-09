import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../data/models/bazaar_details_model.dart';

class BazaarDetailsViewModel extends ChangeNotifier {
  BazaarDetailsModel? _bazaarDetails;
  bool _isLoading = false;
  String? _errorMessage;

  BazaarDetailsModel? get bazaarDetails => _bazaarDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetches the dynamic mock data based on the provided bazaar/event ID
  Future<void> fetchBazaarDetails(String bazaarId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulating a network fetch delay for UI transition realism.
      // This is production-ready for replacing with a true Repository API call.
      await Future.delayed(const Duration(seconds: 1));

      // In the future: `_bazaarDetails = await apiRepository.getBazaarById(bazaarId);`
      // Right now, using mock payload matching the UI constraints tightly.
      _bazaarDetails = BazaarDetailsModel(
        id: bazaarId,
        title: 'cairo_artisan_bazaar'.tr().tr(),
        description:
            'The heart of Egyptian craftsmanship. Experience traditional bazaar vibes with modern local brands.',
        imageUrl:
            'https://images.unsplash.com/photo-1610701596007-11502861dcfa?q=80&w=300&auto=format&fit=crop', // Replace with any real image link containing bazaar items
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
    } catch (e) {
      _errorMessage = 'Failed to fetch details. Please try again.';
    } finally {
      // Clear loading state after everything
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Launch external calls, URLs, or WhatsApp deeply (simulated here)
  void contactOrganizer(String method) {
    debugPrint('Opening $method link...');
  }
}
