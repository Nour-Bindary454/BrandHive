import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class AdminRepositoryImpl implements AdminRepository {
  @override
  Future<Either<Failure, List<AdminStatModel>>> getDashboardStats() async {
    try {
      // Mocking data from the UI image
      final stats = [
        AdminStatModel(
          value: "4",
          label: "Pending",
          subtitle: "2 new today",
          icon: Icons.hourglass_empty_rounded,
          color: const Color(0xFF2D4373),
        ),
        AdminStatModel(
          value: "1,284",
          label: "Products",
          subtitle: "+87 this month",
          icon: Icons.inventory_2_outlined,
          color: const Color(0xFF2D4373),
        ),
        AdminStatModel(
          value: "2.8M",
          label: "Revenue EGP",
          subtitle: "+18% vs last mo",
          icon: Icons.attach_money_rounded,
          color: const Color(0xFF2D4373),
        ),
        AdminStatModel(
          value: "344",
          label: "Total Brands",
          subtitle: "+12 this month",
          icon: Icons.grid_view_rounded,
          color: const Color(0xFF2D4373),
        ),
      ];
      return right(stats);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AdminBrandRequest>>> getBrandRequests() async {
    try {
      final requests = [
        AdminBrandRequest(
          id: "1",
          name: "Desert Rose Crafts",
          location: "Cairo",
          category: "Jewelry",
          date: "Mar 10",
          status: BrandStatus.pending,
        ),
        AdminBrandRequest(
          id: "2",
          name: "Oasis Textiles",
          location: "Luxor",
          category: "Ceramics",
          date: "Mar 8",
          status: BrandStatus.pending,
        ),
        AdminBrandRequest(
          id: "3",
          name: "Alexandria Spices",
          location: "Cairo",
          category: "Jewelry",
          date: "Mar 10",
          status: BrandStatus.approved,
        ),
      ];
      return right(requests);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBrandStatus(String id, BrandStatus status) async {
    try {
      // Logic to update status would go here
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
