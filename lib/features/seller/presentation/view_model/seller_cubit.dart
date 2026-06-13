import 'dart:io';
import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/checkout/data/models/order_model.dart';
import 'package:brand/features/seller_registration/data/model/category_model.dart';
import 'package:brand/features/seller_registration/data/repository/seller_reg_repo.dart';
import 'package:brand/features/seller/data/model/seller_models.dart';
import 'package:brand/features/seller/data/repository/seller_repo.dart';
import 'package:brand/features/seller/presentation/view_model/seller_states.dart';
import 'package:brand/features/home/data/models/home_models.dart' hide CategoryModel;
import 'package:brand/features/home/data/repository/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:brand/core/services/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SellerCubit extends Cubit<SellerState> {
  final SellerRepository _repo;
  final BrandRequestRepo _brandRequestRepo; // to load categories when creating product

  SellerCubit(this._repo, this._brandRequestRepo) : super(SellerInitial());

  // Cached lists/data to prevent repeated fetches or easy local updates
  SellerDashboardData? dashboardData;
  List<SellerProductModel> products = [];
  List<OrderModel> orders = [];
  List<SellerInventoryAlert> stockAlerts = [];
  List<CategoryModel> categories = [];
  List<SellerReviewModel> reviews = [];
  SellerAnalyticsData? analyticsData;

  BrandModel? brand;
  File? pickedBrandLogo;

  Future<void> pickBrandLogo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      pickedBrandLogo = File(pickedFile.path);
      emit(SellerInitial());
    }
  }

  void clearPickedBrandLogo() {
    pickedBrandLogo = null;
    emit(SellerInitial());
  }

  File? pickedImage;
  SellerProductModel? editingProduct;

  void setEditingProduct(SellerProductModel? product) {
    editingProduct = product;
    if (product != null) {
      // Clear picked image since we are editing and might keep the old one
      pickedImage = null;
    }
    emit(SellerInitial());
  }

  void clearEditingProduct() {
    editingProduct = null;
    pickedImage = null;
    emit(SellerInitial());
  }

  // Primary image picker helper
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      emit(SellerInitial()); // Emit to rebuild image picker UI
    }
  }

  void clearPickedImage() {
    pickedImage = null;
    emit(SellerInitial());
  }

  // Categories helper
  Future<void> loadCategories() async {
    emit(SellerCategoriesLoading());
    try {
      final homeRepoResult = await sl<HomeRepository>().getAllCategories();
      await homeRepoResult.fold(
        (failure) async {
          categories = await _brandRequestRepo.getCategories();
        },
        (homeCategories) async {
          categories = homeCategories.map((c) => CategoryModel(id: c.id, name: c.name)).toList();
        },
      );
      if (categories.isEmpty) {
        categories = await _brandRequestRepo.getCategories();
      }
      emit(SellerCategoriesSuccess(categories));
    } catch (e) {
      print("[DEBUG] Categories API failed. Starting fallback. Products count: ${products.length}");
      final Map<String, CategoryModel> harvested = {};

      // Fallback 1: Try to harvest from the seller's own products
      if (products.isEmpty) {
        try {
          products = await _repo.getProducts();
          print("[DEBUG] Fetched seller products. Count: ${products.length}");
        } catch (prodErr) {
          print("[DEBUG] Failed to fetch seller products: $prodErr");
        }
      }
      for (final p in products) {
        print("[DEBUG] Processing seller product: ${p.name}, categoryId: '${p.categoryId}', categoryName: '${p.categoryName}'");
        if (p.categoryId.isNotEmpty && p.categoryName.isNotEmpty) {
          harvested[p.categoryId] = CategoryModel(id: p.categoryId, name: p.categoryName);
        }
      }

      // Fallback 2: Fetch public products and harvest categories from them
      if (harvested.isEmpty) {
        try {
          print("[DEBUG] Seller products empty. Fetching public products to harvest categories...");
          final response = await sl<ApiService>().getData(endPoint: "product?page=1&limit=100");
          final List<dynamic> data = response.data['data'] ?? response.data ?? [];
          print("[DEBUG] Fetched public products. Count: ${data.length}");
          for (var item in data) {
            if (item is Map && item['category'] is Map) {
              final catMap = item['category'] as Map;
              final catId = catMap['_id']?.toString() ?? '';
              final catName = catMap['name']?.toString() ?? '';
              if (catId.isNotEmpty && catName.isNotEmpty) {
                harvested[catId] = CategoryModel(id: catId, name: catName);
              }
            }
          }
        } catch (pubErr) {
          print("[DEBUG] Failed to fetch public products fallback: $pubErr");
        }
      }

      if (harvested.isNotEmpty) {
        categories = harvested.values.toList();
        print("[DEBUG] Harvested categories count: ${categories.length} (Names: ${categories.map((c) => c.name).join(', ')})");
        emit(SellerCategoriesSuccess(categories));
      } else {
        print("[DEBUG] No categories harvested from any fallback. Emitting failure.");
        emit(SellerCategoriesFailure(e.toString()));
      }
    }
  }

  // ================= Dashboard =================
  Future<void> getDashboard() async {
    emit(SellerDashboardLoading());
    try {
      dashboardData = await _repo.getDashboard();
      emit(SellerDashboardSuccess(dashboardData!));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerDashboardFailure(failure.errMessage));
    } catch (e) {
      emit(SellerDashboardFailure(e.toString()));
    }
  }

  // ================= Products =================
  Future<void> getProducts() async {
    emit(SellerProductsLoading());
    try {
      products = await _repo.getProducts();
      emit(SellerProductsSuccess(products));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerProductsFailure(failure.errMessage));
    } catch (e) {
      emit(SellerProductsFailure(e.toString()));
    }
  }

  Future<String?> _resolveBrandId() async {
    // 1. Try from loaded products
    for (final p in products) {
      if (p.brandId != null && p.brandId!.isNotEmpty) {
        return p.brandId;
      }
    }

    // 2. Try fetching products from repo
    try {
      final List<SellerProductModel> fetchedProducts = await _repo.getProducts();
      for (final p in fetchedProducts) {
        if (p.brandId != null && p.brandId!.isNotEmpty) {
          return p.brandId;
        }
      }
    } catch (_) {}

    // 3. Fallback: Query brand requests
    final currentUserId = CacheHelper.getData(key: 'id');
    if (currentUserId != null && currentUserId.isNotEmpty) {
      try {
        final response = await sl<ApiService>().getData(endPoint: "brand/request");
        final List requests = response.data['data'] ?? response.data ?? [];
        for (var req in requests) {
          if (req is Map) {
            String reqById = '';
            if (req['requestedBy'] is Map) {
              reqById = req['requestedBy']['_id']?.toString() ?? req['requestedBy']['id']?.toString() ?? '';
            } else {
              reqById = req['requestedBy']?.toString() ?? '';
            }
            if (reqById == currentUserId) {
              final brandName = req['name']?.toString() ?? '';
              final brandsResponse = await sl<ApiService>().getData(endPoint: "brand");
              final List brands = brandsResponse.data['data'] ?? brandsResponse.data ?? [];
              for (var b in brands) {
                if (b is Map && b['name']?.toString().toLowerCase() == brandName.toLowerCase()) {
                  return b['_id']?.toString() ?? b['id']?.toString();
                }
              }
            }
          }
        }
      } catch (_) {}
    }

    // 4. Try matching user name with brand name in full brand list
    final currentUserName = CacheHelper.getData(key: 'name');
    if (currentUserName != null && currentUserName.isNotEmpty) {
      try {
        final brandsResponse = await sl<ApiService>().getData(endPoint: "brand");
        final List brands = brandsResponse.data['data'] ?? brandsResponse.data ?? [];
        for (var b in brands) {
          if (b is Map) {
            final name = b['name']?.toString() ?? '';
            if (name.toLowerCase() == currentUserName.toLowerCase()) {
              return b['_id']?.toString() ?? b['id']?.toString();
            }
          }
        }
      } catch (_) {}
    }

    return null;
  }

  Future<void> createProduct({
    required String name,
    required String description,
    required double price,
    required int stock,
    required String categoryId,
    double? costPrice,
    String? sku,
    List<String>? tags,
    bool isActive = true,
  }) async {
    emit(SellerProductActionLoading());
    try {
      final brandId = await _resolveBrandId();
      if (brandId == null) {
        emit(SellerProductActionFailure('Could not resolve seller brand ID. Make sure you are registered.'));
        return;
      }

      final body = {
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'category': categoryId,
        'brand': brandId,
        if (sku != null) 'sku': sku,
        if (tags != null) 'tags': tags,
        if (pickedImage != null) 'image': pickedImage,
      };

      final newProduct = await _repo.createProduct(body);
      products.insert(0, newProduct); // Add locally
      clearPickedImage();
      emit(SellerProductActionSuccess('Product created successfully!', product: newProduct));
      getProducts(); // refresh products list
      getDashboard(); // refresh stats
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerProductActionFailure(failure.errMessage));
    } catch (e) {
      emit(SellerProductActionFailure(e.toString()));
    }
  }

  Future<void> updateProduct({
    required String productId,
    required String name,
    required String description,
    required double price,
    required int stock,
    required String categoryId,
    double? costPrice,
    String? sku,
    List<String>? tags,
    bool isActive = true,
  }) async {
    emit(SellerProductActionLoading());
    try {
      final body = {
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'category': categoryId,
        if (sku != null) 'sku': sku,
        if (tags != null) 'tags': tags,
        if (pickedImage != null) 'image': pickedImage,
      };

      final updatedProduct = await _repo.updateProduct(productId, body);
      // Update locally
      final index = products.indexWhere((p) => p.id == productId);
      if (index != -1) {
        products[index] = updatedProduct;
      }
      clearPickedImage();
      emit(SellerProductActionSuccess('Product updated successfully!', product: updatedProduct));
      getProducts(); // refresh products list
      getDashboard(); // refresh stats
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerProductActionFailure(failure.errMessage));
    } catch (e) {
      emit(SellerProductActionFailure(e.toString()));
    }
  }

  Future<void> deleteProduct(String productId) async {
    emit(SellerProductActionLoading());
    try {
      await _repo.deleteProduct(productId);
      products.removeWhere((p) => p.id == productId); // remove locally
      emit(SellerProductActionSuccess('Product deleted successfully!'));
      getDashboard(); // refresh stats
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerProductActionFailure(failure.errMessage));
    } catch (e) {
      emit(SellerProductActionFailure(e.toString()));
    }
  }

  // ================= Stock adjustment =================
  Future<void> adjustStock(String productId, int newQuantity) async {
    emit(SellerProductActionLoading());
    try {
      await _repo.adjustStock(productId, newQuantity);
      
      // Update stock locally
      final index = products.indexWhere((p) => p.id == productId);
      if (index != -1) {
        final current = products[index];
        products[index] = SellerProductModel(
          id: current.id,
          name: current.name,
          description: current.description,
          price: current.price,
          costPrice: current.costPrice,
          stock: newQuantity,
          image: current.image,
          images: current.images,
          categoryId: current.categoryId,
          categoryName: current.categoryName,
          sku: current.sku,
          tags: current.tags,
          isActive: current.isActive,
          rating: current.rating,
          brandId: current.brandId,
          brandName: current.brandName,
        );
      }
      
      emit(SellerStockAdjustmentSuccess('Stock adjusted successfully!'));
      getProducts(); // reload
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerProductActionFailure(failure.errMessage));
    } catch (e) {
      emit(SellerProductActionFailure(e.toString()));
    }
  }

  Future<void> getStockAlerts() async {
    emit(SellerStockAlertsLoading());
    try {
      stockAlerts = await _repo.getStockAlerts();
      emit(SellerStockAlertsSuccess(stockAlerts));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerStockAlertsFailure(failure.errMessage));
    } catch (e) {
      emit(SellerStockAlertsFailure(e.toString()));
    }
  }

  // ================= Orders =================
  Future<void> getOrders({String? status}) async {
    emit(SellerOrdersLoading());
    try {
      orders = await _repo.getOrders(status: status);
      emit(SellerOrdersSuccess(orders));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerOrdersFailure(failure.errMessage));
    } catch (e) {
      emit(SellerOrdersFailure(e.toString()));
    }
  }

  // ================= Analytics & Reviews =================
  Future<void> getAnalytics() async {
    emit(SellerAnalyticsLoading());
    try {
      analyticsData = await _repo.getAnalytics();
      emit(SellerAnalyticsSuccess(analyticsData!));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerAnalyticsFailure(failure.errMessage));
    } catch (e) {
      emit(SellerAnalyticsFailure(e.toString()));
    }
  }

  Future<void> getReviews() async {
    emit(SellerReviewsLoading());
    try {
      reviews = await _repo.getReviews();
      emit(SellerReviewsSuccess(reviews));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerReviewsFailure(failure.errMessage));
    } catch (e) {
      emit(SellerReviewsFailure(e.toString()));
    }
  }

  // ================= Brand Management =================
  Future<void> getBrandDetails() async {
    emit(SellerBrandLoading());
    try {
      final brandId = await _resolveBrandId();
      if (brandId == null) {
        brand = null;
        emit(SellerBrandSuccess(null));
        return;
      }

      // Try fetching using sl<ApiService>().getData
      // 1. Direct detail endpoint
      try {
        final response = await sl<ApiService>().getData(endPoint: "brand/$brandId");
        final data = response.data['data'];
        if (data != null) {
          brand = BrandModel.fromJson(data is List ? data.first : data);
          emit(SellerBrandSuccess(brand));
          return;
        }
      } catch (_) {}

      // 2. Fallback: get-one
      try {
        final response = await sl<ApiService>().getData(
          endPoint: "brand/get-one",
          query: {'id': brandId},
        );
        final data = response.data['data'];
        if (data != null) {
          brand = BrandModel.fromJson(data is List ? data.first : data);
          emit(SellerBrandSuccess(brand));
          return;
        }
      } catch (_) {}

      // 3. Search in full list
      final response = await sl<ApiService>().getData(endPoint: "brand");
      final List brands = response.data['data'] ?? [];
      final match = brands.firstWhere(
        (b) => b['_id'] == brandId || b['id'] == brandId,
        orElse: () => null,
      );
      if (match != null) {
        brand = BrandModel.fromJson(match);
        emit(SellerBrandSuccess(brand));
      } else {
        brand = null;
        emit(SellerBrandSuccess(null));
      }
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerBrandFailure(failure.errMessage));
    } catch (e) {
      emit(SellerBrandFailure(e.toString()));
    }
  }

  Future<void> createBrand({
    required String name,
    required String country,
    required String description,
  }) async {
    emit(SellerBrandLoading());
    try {
      final Map<String, dynamic> body = {
        'name': name,
        'country': country,
        'description': description,
      };

      dynamic requestData = body;
      if (pickedBrandLogo != null) {
        body['logo'] = await MultipartFile.fromFile(
          pickedBrandLogo!.path,
          filename: pickedBrandLogo!.path.split('/').last,
        );
        requestData = FormData.fromMap(body);
      }

      final response = await sl<ApiService>().postData(
        endPoint: "brand",
        data: requestData,
      );

      final data = response.data['data'] ?? response.data;
      brand = BrandModel.fromJson(data is List ? data.first : data);
      pickedBrandLogo = null;
      emit(SellerBrandActionSuccess('Brand created successfully!'));
      emit(SellerBrandSuccess(brand));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerBrandFailure(failure.errMessage));
    } catch (e) {
      emit(SellerBrandFailure(e.toString()));
    }
  }

  Future<void> updateBrand({
    required String brandId,
    required String name,
    required String country,
    required String description,
  }) async {
    emit(SellerBrandLoading());
    try {
      final Map<String, dynamic> body = {
        'name': name,
        'country': country,
        'description': description,
      };

      dynamic requestData = body;
      if (pickedBrandLogo != null) {
        body['logo'] = await MultipartFile.fromFile(
          pickedBrandLogo!.path,
          filename: pickedBrandLogo!.path.split('/').last,
        );
        requestData = FormData.fromMap(body);
      }

      final response = await sl<ApiService>().putData(
        endPoint: "brand/$brandId",
        data: requestData,
      );

      final data = response.data['data'] ?? response.data;
      brand = BrandModel.fromJson(data is List ? data.first : data);
      pickedBrandLogo = null;
      emit(SellerBrandActionSuccess('Brand updated successfully!'));
      emit(SellerBrandSuccess(brand));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(SellerBrandFailure(failure.errMessage));
    } catch (e) {
      emit(SellerBrandFailure(e.toString()));
    }
  }
}
