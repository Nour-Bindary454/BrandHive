import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';

import 'package:brand/features/cart/presentation/cart_screen.dart';
import 'package:brand/features/explore/explore.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/home/presentation/views/home.dart';
import 'package:brand/features/main_layout/presentation/view_model/nav_cubit.dart';
import 'package:brand/features/profile/presentation/views/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Mainlayout extends StatelessWidget {
  Mainlayout({super.key});

  final List<Widget> screens = [
    Center(child: HomeScreen()),
    Center(child: Explore()),
    Center(child: CartScreen()),
    Center(child: ProfileScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LayoutCubit()),
        BlocProvider(create: (_) => sl<HomeCubit>()..loadHomeData()),
      ],
      child: BlocBuilder<LayoutCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: BottomNavigationBar(
                iconSize: 25,
                elevation: 0,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                type: BottomNavigationBarType.fixed,
                backgroundColor: BasicColors.white,
                selectedItemColor: BasicColors.linearGradientDark,
                unselectedItemColor: BasicColors.grey,
                currentIndex: currentIndex,
                onTap: (index) {
                  context.read<LayoutCubit>().changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.explore_outlined),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
