import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/wishlist/data/model/wishlist_model.dart';
import 'package:brand/features/wishlist/data/repository/wishlist_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final Dio dio;

  WishlistRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, WishlistModel>> addToWishlist(String productId) async {
    try {
      final response = await dio.post(
        '/wishlist',
        data: {"productId": productId},
      );

      final wishlist = WishlistModel.fromJson(response.data['data']);

      return Right(wishlist);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, WishlistModel>> getWishlist() async {
    try {
      final response = await dio.get('/wishlist');

      print('====================================');
      print('WISHLIST API RESPONSE:');
      print(response.data);
      print('====================================');

      final wishlist = WishlistModel.fromJson(response.data['data']);

      return Right(wishlist);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  // ➖ NEW: REMOVE
  @override
  Future<Either<Failure, WishlistModel>> removeFromWishlist(
    String productId,
  ) async {
    try {
      final response = await dio.delete('/wishlist/$productId');

      final wishlist = WishlistModel.fromJson(response.data['data']);

      return Right(wishlist);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetails(String productId) async {
    try {
      final response = await dio.get('/product/$productId');
      final data = response.data['data'];

      final String brandName = (data['brand'] is Map) 
          ? (data['brand']['name'] ?? '') 
          : (data['brandName'] ?? '');

      final product = Product(
        id: data['_id'] ?? data['id'] ?? '',
        brandId: (data['brand'] is Map) ? (data['brand']['_id'] ?? '') : '',
        brandName: brandName,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        image: data['mainImage'] ?? data['image'] ?? '',
        rating: (data['stats']?['averageRating'] ?? data['rating'] ?? 0).toDouble(),
        price: (data['price'] ?? 0).toDouble(),
        currency: 'EGP',
        isFavorite: true,
      );

      return Right(product);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
