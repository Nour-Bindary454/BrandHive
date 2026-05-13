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
import 'package:brand/features/orders/presentation/viewmodels/orders_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mainlayout extends StatefulWidget {
  const Mainlayout({super.key});

  @override
  State<Mainlayout> createState() => _MainlayoutState();
}

class _MainlayoutState extends State<Mainlayout> {
  late final List<Widget> _screens;
  late final List<BottomNavigationBarItem> _navItems;
  late final bool _isAdmin;

  @override
  void initState() {
    super.initState();

    final String? role = CacheHelper.getData('role');
    _isAdmin = role?.toLowerCase() == 'admin';
    debugPrint('==== USER ROLE FROM CACHE: $_isAdmin ====');

    _screens = [
      const Center(child: HomeScreen()),
      const Center(child: Explore()),
      if (_isAdmin) const AdminDashboardView(),
      const Center(child: CartScreen()),
      const Center(child: ProfileScreen()),
    ];

    _navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.explore_outlined),
        label: 'Explore',
      ),
      if (_isAdmin)
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
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LayoutCubit()),
        BlocProvider(create: (_) => sl<HomeCubit>()..loadHomeData()),
        BlocProvider(create: (_) => sl<OrdersCubit>()..fetchMyOrders()),
      ],
      child: BlocBuilder<LayoutCubit, int>(
        builder: (context, currentIndex) {
          final activeIndex = currentIndex >= _screens.length ? 0 : currentIndex;
          
          return Scaffold(
            body: IndexedStack(
              index: activeIndex,
              children: _screens,
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
                items: _navItems,
              ),
            ),
          );
        },
      ),
    );
  }
}
