import 'package:brand/features/home/data/models/home_models.dart';

class ExploreState {
  final bool isLoading;
  final String? error;
  final List<HomeProduct> products;

  ExploreState({
    this.isLoading = false,
    this.error,
    this.products = const [],
  });

  ExploreState copyWith({
    bool? isLoading,
    String? error,
    List<HomeProduct>? products,
  }) {
    return ExploreState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      products: products ?? this.products,
    );
  }
}
