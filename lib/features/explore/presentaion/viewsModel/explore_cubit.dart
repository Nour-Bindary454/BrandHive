import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/explore/data/repository/explore_repo.dart';
import 'package:brand/features/explore/presentaion/viewsModel/explore_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreState());

  Future<void> getProducts() async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await sl<ExploreRepository>().getAllProducts(page: 1);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.errMessage));
      },
      (products) {
        emit(state.copyWith(isLoading: false, products: products));
      },
    );
  }
}
