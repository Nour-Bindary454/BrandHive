import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/new_arrivals_repo.dart';
import 'new_arrivals_states.dart';

class NewArrivalsCubit extends Cubit<NewArrivalsState> {
  final NewArrivalsRepo repo;

  NewArrivalsCubit(this.repo) : super(NewArrivalsInitial());

  List products = [];

  Future<void> getNewArrivals() async {
    if (products.isNotEmpty) return;

    emit(NewArrivalsLoading());

    final result = await repo.getNewArrivals();

    result.fold(
      (failure) {
        emit(NewArrivalsError(failure.errMessage));
      },
      (data) {
        products = data;
        emit(NewArrivalsSuccess(data));
      },
    );
  }
}
