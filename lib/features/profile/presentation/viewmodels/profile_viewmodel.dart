import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

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
      // Simulating an API call
      await Future.delayed(const Duration(seconds: 1));

      _profileData = ProfileModel(
        name: 'Mustafa Kamal',
        email: 'mustafa.kamal@example.com',
        imageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704d', // Placeholder 
        membership: 'Gold Member',
        stats: ProfileStats(
          orders: 12,
          reviews: 5,
          points: 240,
        ),
        menuItems: [
          MenuItemModel(
            title: 'My Orders',
            icon: Icons.inventory_2_outlined,
            badgeText: '2 active',
          ),
          MenuItemModel(
            title: 'Wishlist',
            icon: Icons.favorite_border,
            badgeText: '12 items',
          ),
          MenuItemModel(
            title: 'Payment Methods',
            icon: Icons.payment_outlined,
          ),
          MenuItemModel(
            title: 'Notifications',
            icon: Icons.notifications_none_outlined,
            badgeText: 'New',
            isBadgeRed: true,
          ),
          MenuItemModel(
            title: 'Settings',
            icon: Icons.settings_outlined,
          ),
          MenuItemModel(
            title: 'Help & Support',
            icon: Icons.help_outline,
          ),
        ],
      );
    } catch (e) {
      _errorMessage = 'Failed to load profile data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void signOut() {
    // Implement sign out logic
    debugPrint("Signing out...");
  }
}
