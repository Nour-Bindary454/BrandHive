import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/wishlist/data/model/wishlist_model.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRepository {
  Future<Either<Failure, WishlistModel>> removeFromWishlist(String productId);
  Future<Either<Failure, WishlistModel>> addToWishlist(String productId);
  Future<Either<Failure, WishlistModel>> getWishlist();
  Future<Either<Failure, Product>> getProductDetails(String productId);
}
