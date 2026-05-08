import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/brand_profile/data/repository/brand_profile_repo.dart';
import 'package:brand/features/brand_profile/presentation/view_models/brand_profile_states.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandProfileCubit extends Cubit<BrandProfileState> {
  BrandProfileCubit() : super(BrandProfileState());

  Future<void> getBrandProducts(String brandId) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await sl<BrandProfileRepository>().getBrandProducts(brandId);

    result.fold(
      (failure) {
        // Fallback mock data in case API fails
        final mockProducts = List.generate(
          12,
          (index) => HomeProduct(
            id: 'bp$index',
            brandName: 'Mock Brand',
            category: 'Category',
            name: 'Mock Product $index',
            imageUrl: 'https://placehold.co/300x300/png',
            price: 500.0 + (index * 10),
            rating: 4.5,
          ),
        );
        emit(state.copyWith(isLoading: false, products: mockProducts));
      },
      (products) {
        emit(state.copyWith(isLoading: false, products: products));
      },
    );
  }
}
