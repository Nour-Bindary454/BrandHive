import 'package:flutter/material.dart';

class ProfileModel {
  final String name;
  final String email;
  final String imageUrl;
  final String membership;
  final ProfileStats stats;
  final List<MenuItemModel> menuItems;

  ProfileModel({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.membership,
    required this.stats,
    required this.menuItems,
  });
}

class ProfileStats {
  final int orders;
  final int reviews;
  final int points;

  ProfileStats({
    required this.orders,
    required this.reviews,
    required this.points,
  });
}

class MenuItemModel {
  final String title;
  final IconData icon;
  final String? badgeText;
  final bool isBadgeRed;

  MenuItemModel({
    required this.title,
    required this.icon,
    this.badgeText,
    this.isBadgeRed = false,
  });
}
