import 'package:brand/features/category/presentation/view_models/category_cubit.dart';
import 'package:brand/features/category/presentation/views/widgets/category_header.dart';
import 'package:brand/features/category/presentation/views/widgets/category_filters.dart';
import 'package:brand/features/category/presentation/views/widgets/category_products_grid.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel category;
  const CategoryView({super.key, required this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  String selectedFilter = 'All';
  final List<String> filters = [
    'All',
    'Price: Low',
    'Price: High',
    'Top Rated',
  ];

  List<HomeProduct> _applyFilter(List<HomeProduct> products) {
    final sorted = List<HomeProduct>.from(products);
    switch (selectedFilter) {
      case 'Price: Low':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Top Rated':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        break;
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..fetchProducts(widget.category.id),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return Column(
                children: [
                  CategoryHeader(
                    categoryName: widget.category.name,
                    categoryImage:
                        widget.category.logoUrl ?? 'https://placehold.co/300x300/png',
                    productsCount: 0,
                  ),
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              );
            }

            if (state is CategoryError) {
              return Column(
                children: [
                  CategoryHeader(
                    categoryName: widget.category.name,
                    categoryImage:
                        widget.category.logoUrl ?? 'https://placehold.co/300x300/png',
                    productsCount: 0,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              );
            }

            final rawProducts = state is CategoryLoaded ? state.products : <HomeProduct>[];
            final products = _applyFilter(rawProducts);

            return Column(
              children: [
                CategoryHeader(
                  categoryName: widget.category.name,
                  categoryImage:
                      widget.category.logoUrl ?? 'https://placehold.co/300x300/png',
                  productsCount: products.length,
                ),
                CategoryFilters(
                  filters: filters,
                  selectedFilter: selectedFilter,
                  onFilterSelected: (filter) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                ),
                Expanded(child: CategoryProductsGrid(products: products)),
              ],
            );
          },
        ),
      ),
    );
  }
}
