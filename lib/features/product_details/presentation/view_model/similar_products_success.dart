import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'similar_products_state.dart';

class SimilarProductsSuccess extends SimilarProductsState {
  final List<Product> products;

  const SimilarProductsSuccess(this.products);
}
