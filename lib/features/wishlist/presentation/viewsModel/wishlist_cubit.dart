import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand/features/wishlist/data/model/wishlist_model.dart';
import 'package:brand/features/wishlist/data/repository/wishlist_repo.dart';

part 'wishlist_states.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepository repo;

  WishlistCubit(this.repo) : super(WishlistInitial());

  Future<void> addToWishlist(String productId) async {
    emit(AddWishlistLoading());

    final result = await repo.addToWishlist(productId);

    result.fold(
      (failure) {
        emit(AddWishlistError(failure.errMessage));
      },
      (wishlist) {
        emit(AddWishlistSuccess(wishlist));
      },
    );
  }
}
