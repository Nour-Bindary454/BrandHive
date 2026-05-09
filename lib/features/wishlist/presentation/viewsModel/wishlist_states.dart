import 'package:brand/features/wishlist/data/model/wishlist_model.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistUpdatedState extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {
  final WishlistModel wishlist;

  WishlistSuccess(this.wishlist);
}

class WishlistError extends WishlistState {
  final String error;

  WishlistError(this.error);
}
