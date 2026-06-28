class CouponModel {
  final String id;
  final String code;
  final String? description;
  final String type;
  final double value;
  final double? maxDiscountAmount;
  final double minOrderAmount;
  final int? totalUsageLimit;
  final int totalUsedCount;
  final int maxUsagePerUser;
  final DateTime? expiresAt;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CouponModel({
    required this.id,
    required this.code,
    this.description,
    required this.type,
    required this.value,
    this.maxDiscountAmount,
    this.minOrderAmount = 0,
    this.totalUsageLimit,
    this.totalUsedCount = 0,
    this.maxUsagePerUser = 1,
    this.expiresAt,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  bool get isPercentage => type.toLowerCase() == 'percentage';

  String get discountLabel {
    if (isPercentage) {
      return '${value.toStringAsFixed(0)}% OFF';
    }
    return '${value.toStringAsFixed(0)} EGP OFF';
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['_id'] ?? json['id'] ?? '',
      code: json['code'] ?? '',
      description: json['description'],
      type: json['type'] ?? 'percentage',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      maxDiscountAmount: (json['maxDiscountAmount'] as num?)?.toDouble(),
      minOrderAmount: (json['minOrderAmount'] as num?)?.toDouble() ?? 0.0,
      totalUsageLimit: json['totalUsageLimit'],
      totalUsedCount: json['totalUsedCount'] ?? 0,
      maxUsagePerUser: json['maxUsagePerUser'] ?? 1,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'].toString())
          : null,
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'code': code,
      'type': type,
      'value': value,
      if (description != null && description!.isNotEmpty)
        'description': description,
      if (expiresAt != null)
        'expiresAt':
            '${expiresAt!.year}-${expiresAt!.month.toString().padLeft(2, '0')}-${expiresAt!.day.toString().padLeft(2, '0')}',
      if (minOrderAmount > 0) 'minOrderAmount': minOrderAmount,
      if (maxDiscountAmount != null) 'maxDiscountAmount': maxDiscountAmount,
      if (totalUsageLimit != null) 'totalUsageLimit': totalUsageLimit,
      if (maxUsagePerUser > 0) 'maxUsagePerUser': maxUsagePerUser,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    final map = <String, dynamic>{};
    if (code.isNotEmpty) map['code'] = code;
    if (type.isNotEmpty) map['type'] = type;
    map['value'] = value;
    map['isActive'] = isActive;
    if (description != null) map['description'] = description;
    if (expiresAt != null) {
      map['expiresAt'] =
          '${expiresAt!.year}-${expiresAt!.month.toString().padLeft(2, '0')}-${expiresAt!.day.toString().padLeft(2, '0')}';
    }
    if (minOrderAmount > 0) map['minOrderAmount'] = minOrderAmount;
    if (maxDiscountAmount != null) map['maxDiscountAmount'] = maxDiscountAmount;
    if (totalUsageLimit != null) map['totalUsageLimit'] = totalUsageLimit;
    map['maxUsagePerUser'] = maxUsagePerUser;
    return map;
  }
}

class CouponsListResponse {
  final List<CouponModel> coupons;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  CouponsListResponse({
    required this.coupons,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory CouponsListResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final meta = json['meta'] ?? {};

    List<dynamic> list = [];
    if (data is List) {
      list = data;
    } else if (data is Map && data['data'] is List) {
      list = data['data'];
    }

    return CouponsListResponse(
      coupons: list.map((e) => CouponModel.fromJson(e)).toList(),
      total: meta['total'] ?? list.length,
      page: meta['page'] ?? 1,
      limit: meta['limit'] ?? 10,
      totalPages: meta['totalPages'] ?? 1,
    );
  }
}

class CouponValidationResult {
  final bool isValid;
  final double discountAmount;
  final String? message;
  final CouponModel? coupon;

  CouponValidationResult({
    required this.isValid,
    required this.discountAmount,
    this.message,
    this.coupon,
  });

  factory CouponValidationResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    final couponJson = data['coupon'];

    return CouponValidationResult(
      isValid: data['valid'] ?? data['isValid'] ?? true,
      discountAmount: ((data['discountAmount'] ??
              data['discount'] ??
              data['saving'] ??
              0) as num)
          .toDouble(),
      message: data['message'],
      coupon: couponJson is Map<String, dynamic>
          ? CouponModel.fromJson(couponJson)
          : null,
    );
  }
}
