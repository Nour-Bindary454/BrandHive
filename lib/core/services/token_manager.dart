class TokenManager {
  static String? token;

  static void saveToken(String newToken) {
    token = newToken;
  }

  static String? getToken() {
    return token;
  }

  static void clear() {
    token = null;
  }
}
