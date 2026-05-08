import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/explore/presentaion/views/widgets/categ_container.dart';
import 'package:brand/features/category/presentation/views/category_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BrowseAllCat extends StatelessWidget {
  BrowseAllCat({super.key});
  List<String> categories = [
    "Fashion",
    "Home Decor",
    "Accessories",
    "Beauty",
    "HandCrafts",
  ];
  List<String> discription = [
    "Local threads & modern fits",
    "Handcrafted for your space",
    "Jewelry, bags & more",
    "Natural & organic care",
    "Traditional Egyptian crafts",
  ];
  List<String> images = [
    PngImages.fashion,
    PngImages.homeDecor,
    PngImages.accessories,
    PngImages.beauty,
    PngImages.handCrafts,
  ];

  void _navigateToCategory(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryView(
          categoryName: categories[index],
          categoryImage: images[index],
          productsCount: 198, // Dummy count as requested
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 5,
      childAspectRatio: 1.25,
      children: List.generate(
        categories.length,
        (index) => CategContainer(
          tap: () => _navigateToCategory(context, index),
          image: images[index],
          title: categories[index],
          discription: discription[index],
        ),
      ),
    );
  }
}
