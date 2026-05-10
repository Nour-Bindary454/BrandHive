import 'package:brand/features/wishlist/data/repository/wishlist_repo.dart';
import 'package:brand/features/wishlist/presentation/viewsModel/wishlist_states.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepository repo;

  final Set<String> wishlistedProductIds = {};
  List<Product> wishlistProducts = [];

  WishlistCubit(this.repo) : super(WishlistInitial()) {
    fetchWishlist();
  }

  //  GET WISHLIST
  Future<void> fetchWishlist() async {
    final result = await repo.getWishlist();

    result.fold((failure) {}, (wishlist) {
      wishlistedProductIds.clear();
      wishlistProducts.clear();

      for (var item in wishlist.items) {
        wishlistedProductIds.add(item.product.id);
        wishlistProducts.add(Product(
          id: item.product.id,
          brandId: '',
          brandName: item.product.brandName,
          name: item.product.name,
          description: item.product.description,
          image: item.product.image,
          rating: item.product.rating,
          price: item.effectivePrice,
          currency: 'EGP',
          isFavorite: true,
        ));
      }

      emit(WishlistUpdatedState());

      _fetchFullProductDetails();
    });
  }

  Future<void> _fetchFullProductDetails() async {
    bool updated = false;
    for (int i = 0; i < wishlistProducts.length; i++) {
      try {
        final response = await repo.getProductDetails(wishlistProducts[i].id);
        response.fold(
          (failure) => null,
          (fullProduct) {
            wishlistProducts[i] = fullProduct.copyWith(isFavorite: true);
            updated = true;
          },
        );
      } catch (e) {
        // Ignore individual failures
      }
    }
    if (updated) {
      emit(WishlistUpdatedState());
    }
  }

  //  CHECK
  bool isFavorite(String productId, bool initialIsFavorite) {
    return wishlistedProductIds.contains(productId);
  }

  //  TOGGLE (ADD / REMOVE)
  Future<void> toggleWishlist(String productId) async {
    final isFav = wishlistedProductIds.contains(productId);

    // optimistic UI
    if (isFav) {
      wishlistedProductIds.remove(productId);
    } else {
      wishlistedProductIds.add(productId);
    }

    emit(WishlistUpdatedState());

    final result = isFav
        ? await repo.removeFromWishlist(productId)
        : await repo.addToWishlist(productId);

    result.fold(
      (failure) {
        // revert لو حصل error
        if (isFav) {
          wishlistedProductIds.add(productId);
        } else {
          wishlistedProductIds.remove(productId);
        }

        emit(WishlistError(failure.errMessage));
        emit(WishlistUpdatedState());
      },
      (wishlist) {
        // sync مع السيرفر
        wishlistedProductIds.clear();
        wishlistProducts.clear();

        for (var item in wishlist.items) {
          wishlistedProductIds.add(item.product.id);
          wishlistProducts.add(Product(
            id: item.product.id,
            brandId: '',
            brandName: item.product.brandName,
            name: item.product.name,
            description: item.product.description,
            image: item.product.image,
            rating: item.product.rating,
            price: item.effectivePrice,
            currency: 'EGP',
            isFavorite: true,
          ));
        }

        emit(WishlistUpdatedState());
        _fetchFullProductDetails();
      },
    );
  }

  Future<void> clearWishlist() async {
    final idsToRemove = List<String>.from(wishlistedProductIds);
    wishlistProducts.clear();
    wishlistedProductIds.clear();
    emit(WishlistUpdatedState());

    for (var id in idsToRemove) {
      try {
        await repo.removeFromWishlist(id);
      } catch (e) {
        // Ignore individual failures so it continues clearing the rest
      }
    }
  }
}
