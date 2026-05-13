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

  static const String resetPassword = "auth/reset-password";
  static const String notifications = "notifications";
  static const String notificationsUnreadCount = "notifications/unread-count";
  static const String notificationsReadAll = "notifications/read-all";
  static String adminOrders = "orders/admin/all";

  static String activateBrand(String id) => "brand/$id/activate";
  static String deactivateBrand(String id) => "brand/$id/deactivate";
  static String brandAction(String id) => "brand/$id";
}
