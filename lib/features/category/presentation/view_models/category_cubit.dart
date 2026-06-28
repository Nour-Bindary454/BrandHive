import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  Future<void> fetchProducts(String categoryId) async {
    emit(CategoryLoading());

    final result = await sl<HomeRepository>().getProductsByCategory(categoryId);

    result.fold(
      (failure) => emit(CategoryError(failure.errMessage)),
      (products) => emit(CategoryLoaded(products)),
    );
  }
}
