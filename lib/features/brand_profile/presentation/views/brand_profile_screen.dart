import 'package:flutter/material.dart';
import '../view_models/brand_profile_view_model.dart';
import '../widgets/brand_header_section.dart';
import '../widgets/loading_skeleton.dart';
import '../widgets/product_card.dart';

class BrandProfileScreen extends StatefulWidget {
  const BrandProfileScreen({super.key});

  @override
  State<BrandProfileScreen> createState() => _BrandProfileScreenState();
}

class _BrandProfileScreenState extends State<BrandProfileScreen> {
  final _viewModel = BrandProfileViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelUpdate);
    _viewModel.loadData();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: _viewModel.isLoading
          ? const LoadingSkeleton()
          : _viewModel.error != null
          ? Center(child: Text(_viewModel.error!))
          : CustomScrollView(
              slivers: [
                // Sticky Header with Cover Image
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () =>
                        Navigator.of(context).pop(), // Need meaningful nav
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      shape: const CircleBorder(),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.share_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        shape: const CircleBorder(),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: _viewModel.brand != null
                        ? Image.asset(
                            _viewModel.brand!.coverImage,
                            fit: BoxFit.cover,
                          )
                        : Container(color: Colors.grey),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(20),
                    child: Container(
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FB),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                    ),
                  ),
                ),

                // Brand Info & Header
                if (_viewModel.brand != null)
                  BrandHeaderSection(
                    brand: _viewModel.brand!,
                    onFollowPressed: _viewModel.toggleFollow,
                  ),

                // Product Grid
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = _viewModel.products[index];
                      return ProductCard(
                        product: product,
                        onFavoritePressed: () =>
                            _viewModel.toggleFavorite(product.id),
                        onAddToCartPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${product.name} to cart'),
                              duration: const Duration(milliseconds: 500),
                            ),
                          );
                        },
                      );
                    }, childCount: _viewModel.products.length),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
    );
  }
}
