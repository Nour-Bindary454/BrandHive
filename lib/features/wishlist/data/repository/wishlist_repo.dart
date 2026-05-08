import 'package:brand/features/wishlist/data/model/wishlist_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class WishlistRepository {
  Future<Either<Failure, WishlistModel>> addToWishlist(String productId);
}
