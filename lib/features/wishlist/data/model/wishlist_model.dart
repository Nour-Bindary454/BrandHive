class WishlistModel {
  final String id;
  final List<WishlistItemModel> items;
  final int totalItems;
  final int inStockCount;
  final int outOfStockCount;
  final int priceDropCount;

  WishlistModel({
    required this.id,
    required this.items,
    required this.totalItems,
    required this.inStockCount,
    required this.outOfStockCount,
    required this.priceDropCount,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'] ?? '',
      items: (json['items'] as List)
          .map((e) => WishlistItemModel.fromJson(e))
          .toList(),
      totalItems: json['totalItems'] ?? 0,
      inStockCount: json['inStockCount'] ?? 0,
      outOfStockCount: json['outOfStockCount'] ?? 0,
      priceDropCount: json['priceDropCount'] ?? 0,
    );
  }
}

class WishlistItemModel {
  final WishlistProductModel product;
  final double effectivePrice;
  final bool inStock;
  final bool isAvailable;

  WishlistItemModel({
    required this.product,
    required this.effectivePrice,
    required this.inStock,
    required this.isAvailable,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      product: WishlistProductModel.fromJson(json['product']),
      effectivePrice: (json['effectivePrice'] ?? 0).toDouble(),
      inStock: json['inStock'] ?? false,
      isAvailable: json['isAvailable'] ?? false,
    );
  }
}

class WishlistProductModel {
  final String id;
  final String name;
  final String image;
  final double rating;
  final String description;
  final String brandName;

  WishlistProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.description,
    required this.brandName,
  });

  factory WishlistProductModel.fromJson(Map<String, dynamic> json) {
    String parsedBrandName = '';
    if (json['brand'] is Map) {
      parsedBrandName = json['brand']['name'] ?? '';
    } else if (json['brandName'] != null) {
      parsedBrandName = json['brandName'];
    } else if (json['brand'] is String) {
      // Just in case it returns brand name as string instead of ID
      parsedBrandName = json['brand'];
    }

    return WishlistProductModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? json['mainImage'] ?? '',
      rating: (json['rating'] ?? json['stats']?['averageRating'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      brandName: parsedBrandName,
    );
  }
}
