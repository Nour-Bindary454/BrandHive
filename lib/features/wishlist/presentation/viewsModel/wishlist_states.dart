part of 'wishlist_cubit.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class AddWishlistLoading extends WishlistState {}

class AddWishlistSuccess extends WishlistState {
  final WishlistModel wishlist;

  AddWishlistSuccess(this.wishlist);
}

class AddWishlistError extends WishlistState {
  final String error;

  AddWishlistError(this.error);
}
