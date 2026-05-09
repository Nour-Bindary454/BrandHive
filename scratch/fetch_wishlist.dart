import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('No token found');
      return;
    }

    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://brand-1-e40y.onrender.com/api/v1',
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    final response = await dio.get('/wishlist');
    print(response.data);
  } catch (e) {
    print('Error: $e');
  }
}
