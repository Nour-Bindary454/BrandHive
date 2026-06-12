import 'package:flutter/material.dart';

class SubcategoryTabs extends StatefulWidget {
  const SubcategoryTabs({super.key});

  @override
  State<SubcategoryTabs> createState() => _SubcategoryTabsState();
}

class _SubcategoryTabsState extends State<SubcategoryTabs> {
  List<String> sortOptions = [
    "Popular",
    "Newest",
    "Low Price",
    "High Price",
    "Top Rated",
  ];
  int selectedSortIndex = 0;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
