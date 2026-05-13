import 'package:flutter/material.dart';

class AdminStatModel {
  final String value;
  final String label;
  final String subtitle;
  final IconData icon;
  final Color color;

  AdminStatModel({
    required this.value,
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

enum BrandStatus { pending, approved, rejected }

class AdminBrandRequest {
  final String id;
  final String name;
  final String location;
  final String category;
  final String date;
  final BrandStatus status;

  AdminBrandRequest({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.date,
    required this.status,
  });

  AdminBrandRequest copyWith({BrandStatus? status}) {
    return AdminBrandRequest(
      id: id,
      name: name,
      location: location,
      category: category,
      date: date,
      status: status ?? this.status,
    );
  }
}
