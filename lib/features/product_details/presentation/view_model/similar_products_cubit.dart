import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/product_details/presentation/view_model/similar_products_state.dart';
import 'package:brand/features/product_details/presentation/view_model/similar_products_initial.dart';
import 'package:brand/features/product_details/presentation/view_model/similar_products_loading.dart';
import 'package:brand/features/product_details/presentation/view_model/similar_products_success.dart';
import 'package:brand/features/product_details/presentation/view_model/similar_products_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarProductsCubit extends Cubit<SimilarProductsState> {
  final ApiService api;

  SimilarProductsCubit(this.api) : super(const SimilarProductsInitial());

  Future<void> getSimilarProducts(String productId) async {
    emit(const SimilarProductsLoading());
    try {
      final response = await api.getData(
        endPoint: EndPoints.similarProducts(productId),
      );
      final list = response.data['similar'] as List;
      final products = list.map((e) => Product.fromJson(e)).toList();
      emit(SimilarProductsSuccess(products));
    } catch (e) {
      emit(SimilarProductsError(e.toString()));
    }
  }
}
