import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/category/presentation/views/widgets/category_header.dart';
import 'package:brand/features/category/presentation/views/widgets/category_filters.dart';
import 'package:brand/features/category/presentation/views/widgets/category_products_grid.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  final String categoryName;
  final String categoryImage;
  final int productsCount;

  const CategoryView({
    super.key,
    required this.categoryName,
    required this.categoryImage,
    required this.productsCount,
  });

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

  @override
  Widget build(BuildContext context) {
    // Dummy products
    final List<Product> categoryProducts = List.generate(
      6,
      (index) => Product(
        brandName: 'Brand Name',
        id: 'p$index',
        brandId: '1',
        name: index % 2 == 0 ? 'Single Hanging Chair' : 'Classic Glass Vase',
        image: index % 2 == 0 ? PngImages.fashion : PngImages.homeDecor,
        rating: 4.8,
        price: index % 2 == 0 ? 600.0 : 450.0,
        currency: 'EGP',
        isFavorite: false,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CategoryHeader(
            categoryName: widget.categoryName,
            categoryImage: widget.categoryImage,
            productsCount: widget.productsCount,
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
          Expanded(child: CategoryProductsGrid(products: categoryProducts)),
        ],
      ),
    );
  }
}
