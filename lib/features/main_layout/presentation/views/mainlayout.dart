import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';

import 'package:brand/features/cart/presentation/cart_screen.dart';
import 'package:brand/features/explore/presentaion/views/explore.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/home/presentation/views/home.dart';
import 'package:brand/features/main_layout/presentation/view_model/nav_cubit.dart';
import 'package:brand/features/profile/presentation/views/profile_screen.dart';
import 'package:brand/features/admin_dashboard/presentation/views/admin_dashboard_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Mainlayout extends StatelessWidget {
  Mainlayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Get user role from cache
    final String? role = CacheHelper.getData('role');
    debugPrint('==== USER ROLE FROM CACHE: $role ====');
    final bool isAdmin = role?.toLowerCase() == 'admin';

    // Build screens list dynamically
    final List<Widget> screens = [
      const Center(child: HomeScreen()),
      const Center(child: Explore()),
      if (isAdmin) const AdminDashboardView(),
      const Center(child: CartScreen()),
      const Center(child: ProfileScreen()),
    ];

    // Build navigation items dynamically
    final List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.explore_outlined),
        label: 'Explore',
      ),
      if (isAdmin)
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          label: 'Dashboard',
        ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag_outlined),
        label: 'Cart',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        label: 'Profile',
      ),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LayoutCubit()),
        BlocProvider(create: (_) => sl<HomeCubit>()..loadHomeData()),
      ],
      child: BlocBuilder<LayoutCubit, int>(
        builder: (context, currentIndex) {
          // Safety check for index out of bounds when role changes (though role is usually static per session)
          final activeIndex = currentIndex >= screens.length ? 0 : currentIndex;
          
          return Scaffold(
            body: IndexedStack(
              index: activeIndex,
              children: screens,
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: BottomNavigationBar(
                iconSize: 25,
                elevation: 0,
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                type: BottomNavigationBarType.fixed,
                backgroundColor: Theme.of(context).colorScheme.surface,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
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
