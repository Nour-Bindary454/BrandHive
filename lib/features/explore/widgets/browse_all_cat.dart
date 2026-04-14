import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/explore/widgets/categ_container.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true, // مهم جداً عشان الـ Grid مياخدش طول لا نهائي
      physics:
          NeverScrollableScrollPhysics(), // عشان الشاشة كلها تعمل Scroll مرة واحدة
      crossAxisCount: 2, // عمودين
      mainAxisSpacing: 10, // مسافة رأسية
      crossAxisSpacing: 5, // مسافة أفقية
      childAspectRatio: 1.25, // بيتحكم في "تربيعة" الكارت (عرضه بالنسبة لطوله)
      children: [
        CategContainer(
          tap: () {},
          image: images[0],
          title: categories[0],
          discription: discription[0],
        ),
        CategContainer(
          tap: () {},
          image: images[1],
          title: categories[1],
          discription: discription[1],
        ),
        CategContainer(
          tap: () {},
          image: images[2],
          title: categories[2],
          discription: discription[2],
        ),
        CategContainer(
          tap: () {},
          image: images[3],
          title: categories[3],
          discription: discription[3],
        ),
        CategContainer(
          tap: () {},
          image: images[4],
          title: categories[4],
          discription: discription[4],
        ),
      ],
    );
  }
}
