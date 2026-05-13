import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewModel/new_arrivals_cubit.dart';
import '../viewModel/new_arrivals_states.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';

class NewArrivalsScreen extends StatelessWidget {
  const NewArrivalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Arrivals')),

      body: BlocBuilder<NewArrivalsCubit, NewArrivalsState>(
        builder: (context, state) {
          if (state is NewArrivalsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NewArrivalsError) {
            return Center(child: Text(state.error));
          }

          if (state is NewArrivalsSuccess) {
            final products = state.products;

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(
                  product: Product(
                    id: product.id,
                    brandId: '',
                    brandName: product.brandName,
                    name: product.name,
                    description: product.description,
                    image: product.image,
                    rating: product.rating,
                    price: product.price,
                    currency: 'EGP',
                    isFavorite: false,
                  ),
                  onFavoritePressed: () {},
                  onAddToCartPressed: () {},
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
