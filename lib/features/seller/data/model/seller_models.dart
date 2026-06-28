import 'package:brand/features/checkout/data/models/order_model.dart';

class SellerDashboardData {
  final double totalRevenue;
  final int activeOrdersCount;
  final int profileViews;
  final int productsCount;
  final double rating;
  final List<OrderModel> recentOrders;

  SellerDashboardData({
    required this.totalRevenue,
    required this.activeOrdersCount,
    required this.profileViews,
    required this.productsCount,
    required this.rating,
    required this.recentOrders,
  });

  factory SellerDashboardData.fromJson(Map<String, dynamic> json) {
    final productsMap = json['products'] as Map<String, dynamic>?;
    final ordersMap = json['orders'] as Map<String, dynamic>?;
    final revenueMap = json['revenue'] as Map<String, dynamic>?;
    final reviewsMap = json['reviews'] as Map<String, dynamic>?;
    final engagementMap = json['engagement'] as Map<String, dynamic>?;

    final double totalRevenue = (revenueMap?['total'] ?? json['totalRevenue'] ?? json['revenue'] ?? 0).toDouble();
    final int activeOrdersCount = ordersMap?['pending'] ?? ordersMap?['total'] ?? json['activeOrdersCount'] ?? json['activeOrders'] ?? 0;
    final int profileViews = engagementMap?['totalViews'] ?? json['profileViews'] ?? 0;
    final int productsCount = productsMap?['total'] ?? json['productsCount'] ?? json['products'] ?? 0;
    final double rating = (reviewsMap?['averageRating'] ?? json['rating'] ?? 0.0).toDouble();

    var ordersList = json['recentOrders'] as List? ?? [];
    List<OrderModel> orders = ordersList.map((e) => OrderModel.fromJson(e)).toList();

    return SellerDashboardData(
      totalRevenue: totalRevenue,
      activeOrdersCount: activeOrdersCount,
      profileViews: profileViews,
      productsCount: productsCount,
      rating: rating,
      recentOrders: orders,
    );
  }
}

class SellerProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? costPrice;
  final int stock;
  final String image;
  final List<String> images;
  final String categoryId;
  final String categoryName;
  final String? sku;
  final List<String> tags;
  final bool isActive;
  final double rating;
  final String? brandId;
  final String? brandName;

  SellerProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.costPrice,
    required this.stock,
    required this.image,
    required this.images,
    required this.categoryId,
    required this.categoryName,
    this.sku,
    required this.tags,
    required this.isActive,
    required this.rating,
    this.brandId,
    this.brandName,
  });

  factory SellerProductModel.fromJson(Map<String, dynamic> json) {
    // Handling different format of image or images array
    String mainImage = '';
    List<String> imagesList = [];
    
    if (json['images'] is List) {
      for (var item in json['images']) {
        if (item is String) {
          imagesList.add(item);
        } else if (item is Map && item['url'] != null) {
          imagesList.add(item['url'].toString());
        }
      }
    }
    
    if (json['image'] is String) {
      mainImage = json['image'].toString();
    } else if (json['image'] is Map && json['image']['url'] != null) {
      mainImage = json['image']['url'].toString();
    }
    
    if (mainImage.isEmpty && imagesList.isNotEmpty) {
      mainImage = imagesList.first;
    }
    if (imagesList.isEmpty && mainImage.isNotEmpty) {
      imagesList = [mainImage];
    }

    String catId = '';
    String catName = '';
    if (json['category'] is Map) {
      catId = json['category']['_id'] ?? '';
      catName = json['category']['name'] ?? '';
    } else if (json['category'] != null) {
      catId = json['category'].toString();
    }

    String bId = '';
    String bName = '';
    if (json['brand'] is Map) {
      bId = json['brand']['_id'] ?? '';
      bName = json['brand']['name'] ?? '';
    } else if (json['brand'] != null) {
      bId = json['brand'].toString();
    }

    return SellerProductModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      costPrice: json['costPrice'] != null ? (json['costPrice'] ?? 0).toDouble() : null,
      stock: json['stock'] ?? json['quantity'] ?? json['countInStock'] ?? 0,
      image: mainImage,
      images: imagesList,
      categoryId: catId,
      categoryName: catName,
      sku: json['sku'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      isActive: json['isActive'] ?? true,
      rating: (json['rating'] ?? (json['stats'] is Map ? json['stats']['averageRating'] : null) ?? 0.0).toDouble(),
      brandId: bId,
      brandName: bName,
    );
  }
}

class SellerInventoryAlert {
  final String productId;
  final String productName;
  final int stock;
  final int threshold;

  SellerInventoryAlert({
    required this.productId,
    required this.productName,
    required this.stock,
    required this.threshold,
  });

  factory SellerInventoryAlert.fromJson(Map<String, dynamic> json) {
    return SellerInventoryAlert(
      productId: json['productId'] ?? json['product'] ?? '',
      productName: json['productName'] ?? json['name'] ?? '',
      stock: json['stock'] ?? 0,
      threshold: json['threshold'] ?? 5,
    );
  }
}

class SellerReviewModel {
  final String id;
  final String reviewerName;
  final double rating;
  final String comment;
  final String productName;
  final DateTime? createdAt;

  SellerReviewModel({
    required this.id,
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.productName,
    this.createdAt,
  });

  factory SellerReviewModel.fromJson(Map<String, dynamic> json) {
    String reviewer = 'Customer';
    if (json['user'] is Map) {
      reviewer = json['user']['name'] ?? 'Customer';
    } else if (json['reviewerName'] != null) {
      reviewer = json['reviewerName'].toString();
    }

    String prodName = '';
    if (json['product'] is Map) {
      prodName = json['product']['name'] ?? '';
    } else if (json['productName'] != null) {
      prodName = json['productName'].toString();
    }

    return SellerReviewModel(
      id: json['_id'] ?? json['id'] ?? '',
      reviewerName: reviewer,
      rating: (json['rating'] ?? 0.0).toDouble(),
      comment: json['comment'] ?? json['reviewText'] ?? '',
      productName: prodName,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    );
  }
}

class SellerAnalyticsData {
  final double totalSales;
  final int totalOrders;
  final double averageOrderValue;
  final List<dynamic> monthlySales;

  SellerAnalyticsData({
    required this.totalSales,
    required this.totalOrders,
    required this.averageOrderValue,
    required this.monthlySales,
  });

  factory SellerAnalyticsData.fromJson(Map<String, dynamic> json) {
    return SellerAnalyticsData(
      totalSales: (json['totalSales'] ?? json['sales'] ?? 0.0).toDouble(),
      totalOrders: json['totalOrders'] ?? json['orders'] ?? 0,
      averageOrderValue: (json['averageOrderValue'] ?? 0.0).toDouble(),
      monthlySales: json['monthlySales'] ?? json['chartData'] ?? [],
    );
  }
}

class ProductInsightItem {
  final String id;
  final String name;
  final String categoryName;
  final int viewCount;
  final int cartCount;
  final int wishlistCount;

  ProductInsightItem({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.viewCount,
    required this.cartCount,
    required this.wishlistCount,
  });

  factory ProductInsightItem.fromJson(Map<String, dynamic> json) {
    return ProductInsightItem(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      categoryName: json['category_name'] ??
          (json['category'] is Map
              ? json['category']['name'] ?? ''
              : json['category']?.toString() ?? ''),
      viewCount: json['viewCount'] ?? json['views'] ?? 0,
      cartCount: json['cartCount'] ?? json['cartAdds'] ?? 0,
      wishlistCount: json['wishlistCount'] ?? json['wishlists'] ?? 0,
    );
  }
}

class ProductInsightsData {
  final List<ProductInsightItem> products;

  ProductInsightsData({required this.products});

  factory ProductInsightsData.fromJson(dynamic raw) {
    if (raw is List) {
      return ProductInsightsData(
        products: raw
            .whereType<Map>()
            .map((e) => ProductInsightItem.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
    }

    final map = raw is Map ? Map<String, dynamic>.from(raw) : <String, dynamic>{};
    final data = map['data'] ?? map;
    final list = (data is Map ? data['products'] : map['products']) as List? ?? [];

    return ProductInsightsData(
      products: list
          .whereType<Map>()
          .map((e) => ProductInsightItem.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}
