import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/end_points.dart';
import '../../../orders/data/models/user_order_model.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileModel? _profileData;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileModel? get profileData => _profileData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ProfileViewModel() {
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch active orders count dynamically
      int activeOrdersCount = 0;
      try {
        final response = await sl<ApiService>().getData(endPoint: EndPoints.myOrders);
        final List data = response.data['data'] ?? [];
        final orders = data.map((e) => UserOrderModel.fromJson(e)).toList();
        activeOrdersCount = orders.where((o) => 
          o.status.toLowerCase() != 'delivered' && 
          o.status.toLowerCase() != 'cancelled'
        ).length;
      } catch (e) {
        debugPrint("Failed to fetch active orders count: $e");
      }

      _profileData = ProfileModel(
        name: CacheHelper.getData(key: 'name') ?? 'User',
        email: CacheHelper.getData(key: 'email') ?? 'user@example.com',
        imageUrl:
            'https://i.pravatar.cc/150?u=a042581f4e29026704d', // Placeholder
        membership: 'Gold Member',
        stats: ProfileStats(orders: 12, reviews: 5, points: 240),
        menuItems: [
          MenuItemModel(
            title: 'my_orders'.tr(),
            icon: Icons.inventory_2_outlined,
            badgeText: activeOrdersCount > 0 ? '$activeOrdersCount active' : null,
          ),
          MenuItemModel(
            title: 'wishlist'.tr(),
            icon: Icons.favorite_border,
            badgeText: '12 items',
          ),
          MenuItemModel(
            title: 'payment_methods'.tr(),
            icon: Icons.payment_outlined,
          ),
          MenuItemModel(
            title: 'notifications'.tr(),
            icon: Icons.notifications_none_outlined,
            badgeText: 'New',
            isBadgeRed: true,
          ),
          MenuItemModel(title: 'settings'.tr(), icon: Icons.settings_outlined),
          MenuItemModel(title: 'help_support'.tr(), icon: Icons.help_outline),
        ],
      );
    } catch (e) {
      _errorMessage = 'Failed to load profile data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void signOut(BuildContext context) {
    // Clear token
    CacheHelper.removeData(key: 'token');

    // Navigate to Login and clear stack
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

    debugPrint("Signing out...");
  }
}
