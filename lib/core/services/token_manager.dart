import 'package:brand/core/services/cache_helper.dart';

class TokenManager {
  static Future<void> saveToken(String token) async {
    await CacheHelper.saveData(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    return CacheHelper.getData('token');
  }

  static Future<void> clear() async {
    CacheHelper.removeData('token');
  }
}
