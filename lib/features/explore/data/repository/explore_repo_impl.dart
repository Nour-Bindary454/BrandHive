import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';
import 'explore_repo.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ApiService apiService;

  ExploreRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<HomeProduct>>> getAllProducts({
    int page = 1,
  }) async {
    try {
      final response = await apiService.getData(
        endPoint: "${EndPoints.products}?page=$page&limit=100",
      );

      final List<dynamic> data = response.data['data'] ?? [];
      final List<HomeProduct> products = data
          .map((p) => HomeProduct.fromJson(p))
          .toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeProduct>>> searchProducts(
    String query, {
    bool? shipsInternationally,
  }) async {
    try {
      String url = "search/products?search=$query";
      if (shipsInternationally != null) {
        url += "&shipsInternationally=$shipsInternationally";
      }
      final response = await apiService.getData(
        endPoint: url,
      );

      final List<dynamic> data = response.data['data'] ?? [];
      final List<HomeProduct> products = data
          .map((p) => HomeProduct.fromJson(p))
          .toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getTrendingProducts() async {
    try {
      final response = await apiService.getData(endPoint: EndPoints.aiTrending);

      final List<dynamic> data = response.data['products'] ?? [];
      final List<Product> products = data.map((p) {
        final product = Product.fromJson(p);
        String imageUrl = '';
        final id = product.id;

        // Map premium Unsplash images to make the AI features look stunning
        if (id == '49f6cfa752794acb9676d3d2') {
          imageUrl =
              "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=400";
        } else if (id == '28cc5f2baa7842c8ae8dd807') {
          imageUrl =
              "https://images.unsplash.com/photo-1595777457583-95e059d581b8?q=80&w=400";
        } else if (id == '0ebd3e935943491184a1b442') {
          imageUrl =
              "https://images.unsplash.com/photo-1554412933-514a83d2f3c8?q=80&w=400";
        } else if (id == '448453a100eb461db2378a9c') {
          imageUrl =
              "https://images.unsplash.com/photo-1612336307429-8a898d10e223?q=80&w=400";
        } else if (id == 'b44c4060a2574c67add56de3') {
          imageUrl =
              "https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?q=80&w=400";
        } else if (id == '2f49ce2e0bf24e26ba2316f7') {
          imageUrl =
              "https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?q=80&w=400";
        } else if (id == '41782455cb484aa3ab6acf58') {
          imageUrl =
              "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?q=80&w=400";
        } else if (id == 'b6a0c1ef4c204a2790206b98') {
          imageUrl =
              "https://images.unsplash.com/photo-1509631179647-0177331693ae?q=80&w=400";
        } else if (id == 'ae7e2f4bb40d48ca8a2e9732') {
          imageUrl =
              "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=400";
        } else if (id == '3c415fd3729042df93fee1c4') {
          imageUrl =
              "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=400";
        } else if (id == '80b147378fda463d9b44b2e9') {
          imageUrl =
              "https://images.unsplash.com/photo-1512496015851-a90fb38ba796?q=80&w=400";
        } else if (id == '7ab3b1f415fe469191ac1260') {
          imageUrl =
              "https://images.unsplash.com/photo-1601049541289-9b1b7bbbfe19?q=80&w=400";
        } else {
          final catName = p['category_name']?.toString().toLowerCase() ?? '';
          if (catName == 'fashion') {
            imageUrl =
                "https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=400";
          } else if (catName == 'beauty') {
            imageUrl =
                "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=400";
          } else {
            imageUrl = "https://placehold.co/300x300/png";
          }
        }

        return Product(
          id: product.id,
          brandId: product.brandId,
          brandName: product.brandName,
          name: product.name,
          description: product.description,
          image: imageUrl,
          rating: product.rating,
          price: product.price,
          currency: product.currency,
          isFavorite: product.isFavorite,
          isActive: product.isActive,
        );
      }).toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
