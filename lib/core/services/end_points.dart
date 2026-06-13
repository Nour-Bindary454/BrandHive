class EndPoints {
  static const String baseUrl =
      'https://brandhive-apis-production.up.railway.app/';
  static String register = "auth/register";
  static String confirmEmail = "auth/confirm-email";
  static String verifyresetcode = "auth/verify-reset-code";
  static String resendOtp = "auth/resend-otp";
  static String login = "auth/login";

  static String forgetPassword = "auth/forget-password";
  static String categories = "category";
  static String getall = "brand";
  static String getone = "brand/get-one";
  static String products = "product";
  static String wishlist = "wishlist";

  static String newArrivals = "product/new-arrivals";

  static String cart = "cart";
  static String orders = "orders";
  static String brandRequest = "brand/request";
  static String addresses = "addresses";
  static String shippingFee = "shipping-fee";
  static String paymentWebhook = "payment/webhook/paymob";

  static const String resetPassword = "auth/reset-password";
  static const String notifications = "notifications";
  static const String notificationsUnreadCount = "notifications/unread-count";
  static const String notificationsReadAll = "notifications/read-all";
  static String adminOrders = "orders/admin/all";

  static String activateBrand(String id) => "brand/$id/activate";
  static String deactivateBrand(String id) => "brand/$id/deactivate";
  static String brandAction(String id) => "brand/$id";
  static String support = "support";

  // Seller Endpoints
  static const String sellerDashboard = "seller/dashboard";
  static const String sellerProducts = "seller/products";
  static String sellerProductDetail(String id) => "seller/products/$id";
  static const String sellerStockAlerts = "seller/inventory/alerts";
  static String sellerAdjustStock(String id) => "seller/inventory/$id/adjust";
  static const String sellerOrders = "seller/orders";
  static String sellerOrderDetail(String id) => "seller/orders/$id";
  static const String sellerAnalytics = "seller/analytics";
  static const String sellerReviews = "seller/reviews";

  // Bazaar Endpoints
  static const String myBazaar = "seller/bazaar";
  static const String searchBazaars = "seller/bazaar/search";
  static const String notifyFollowers = "seller/bazaar/notify";
  static const String adminAllBazaars = "seller/bazaar/admin/all";
  static String toggleBazaar(String id) => "seller/bazaar/admin/$id/toggle";
}
