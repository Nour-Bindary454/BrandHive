import 'package:flutter/material.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/explore/data/repository/explore_repo.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/home/data/models/home_models.dart';

class BestSellersScreen extends StatefulWidget {
  const BestSellersScreen({super.key});

  @override
  State<BestSellersScreen> createState() => _BestSellersScreenState();
}

class _BestSellersScreenState extends State<BestSellersScreen> {
  List<Product> _products = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchBestSellers();
  }

  Future<void> _fetchBestSellers() async {
    final result = await sl<ExploreRepository>().getAllProducts(page: 1);
    result.fold(
      (failure) {
        if (mounted) {
          setState(() {
            _errorMessage = failure.errMessage;
            _isLoading = false;
          });
        }
      },
      (homeProducts) {
        // Sort by rating in descending order
        final sorted = List<HomeProduct>.from(homeProducts);
        sorted.sort((a, b) => b.rating.compareTo(a.rating));

        // Take top 25 and convert to Product
        final top25 = sorted.take(25).map((p) => Product(
          id: p.id,
          brandId: '',
          brandName: p.brandName,
          name: p.name,
          description: p.description,
          image: p.imageUrl,
          rating: p.rating,
          price: p.price,
          currency: 'EGP',
          isFavorite: false,
        )).toList();

        if (mounted) {
          setState(() {
            _products = top25;
            _isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Best Sellers',
          style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373)))
          : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red)))
              : _products.isEmpty
                  ? const Center(child: Text('No best sellers found.'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: _products[index],
                          onFavoritePressed: () {},
                          onAddToCartPressed: () {},
                        );
                      },
                    ),
    );
  }
}
