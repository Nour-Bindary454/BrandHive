import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/services/service_locator.dart';

import 'package:brand/features/cart/presentation/cart_screen.dart';
import 'package:brand/features/explore/presentaion/views/explore.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/home/presentation/views/home.dart';
import 'package:brand/features/main_layout/presentation/view_model/nav_cubit.dart';
import 'package:brand/features/profile/presentation/views/profile_screen.dart';
import 'package:brand/features/admin_dashboard/presentation/views/admin_dashboard_view.dart';
import 'package:brand/features/admin_dashboard/presentation/views/admin_products_view.dart';
import 'package:brand/features/admin_dashboard/presentation/views/admin_brands_view.dart';
import 'package:brand/features/settings/presentation/views/settings_view.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brand/features/notifications/presentation/viewmodel/notifications_cubit.dart';

class Mainlayout extends StatelessWidget {
  Mainlayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Get user role from cache
    final String? role = CacheHelper.getData(key: 'role');
    debugPrint('==== USER ROLE FROM CACHE: $role ====');
    final bool isAdmin = role?.toLowerCase() == 'admin';

    // Build screens and nav items dynamically based on role
    final List<Widget> screens;
    final List<BottomNavigationBarItem> navItems;

    if (isAdmin) {
      screens = [
        const AdminDashboardView(),
        const AdminProductsView(),
        const AdminBrandsView(),
        const SettingsView(),
      ];

      navItems = [
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.square_grid_2x2),
          activeIcon: Icon(CupertinoIcons.square_grid_2x2_fill),
          label: 'Dashboard',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.cube_box),
          activeIcon: Icon(CupertinoIcons.cube_box_fill),
          label: 'Products',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bag),
          activeIcon: Icon(CupertinoIcons.bag_fill),
          label: 'Brands',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          activeIcon: Icon(CupertinoIcons.settings),
          label: 'Settings',
        ),
      ];
    } else {
      screens = [
        const Center(child: HomeScreen()),
        const Center(child: Explore()),
        const Center(child: CartScreen()),
        const Center(child: ProfileScreen()),
      ];

      navItems = [
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          activeIcon: Icon(CupertinoIcons.house_fill),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.compass),
          activeIcon: Icon(CupertinoIcons.compass_fill),
          label: 'Explore',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.shopping_cart),
          activeIcon: Icon(CupertinoIcons.cart_fill),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          activeIcon: Icon(CupertinoIcons.person_fill),
          label: 'Profile',
        ),
      ];
    }

    if (!isAdmin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.read<NotificationsCubit>().fetchUnreadCount();
        }
      });
    } else {
      // Admin doesn't visit HomeScreen, so we must manually trigger home data
      // (brands & products) so AdminBrandsView and AdminProductsView have data
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.read<HomeCubit>().loadHomeData();
        }
      });
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LayoutCubit()),
        if (isAdmin) BlocProvider(create: (_) => sl<AdminCubit>()),
      ],
      child: BlocBuilder<LayoutCubit, int>(
        builder: (context, currentIndex) {
          // Safety check for index out of bounds when role changes (though role is usually static per session)
          final activeIndex = currentIndex >= screens.length ? 0 : currentIndex;

          return Scaffold(
            body: IndexedStack(index: activeIndex, children: screens),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: BottomNavigationBar(
                iconSize: 25,
                elevation: 0,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                type: BottomNavigationBarType.fixed,
                backgroundColor: Theme.of(context).colorScheme.surface,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Theme.of(
                  context,
                ).colorScheme.onSurface.withOpacity(0.4),
                currentIndex: activeIndex,
                onTap: (index) {
                  context.read<LayoutCubit>().changeIndex(index);
                },
                items: navItems,
              ),
            ),
          );
        },
      ),
    );
  }
}
