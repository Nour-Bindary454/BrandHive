import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final baseUrl = 'https://brandhive-apis-production.up.railway.app/';
  
  print('Registering user...');
  final regRes = await http.post(
    Uri.parse(baseUrl + 'auth/register'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': 'Test User',
      'email': 'test999126@test.com',
      'password': 'Password123!',
      'confirmPassword': 'Password123!'
    })
  );
  print('Reg Response: ${regRes.statusCode} - ${regRes.body}');
  
  print('Logging in...');
  final loginRes = await http.post(
    Uri.parse(baseUrl + 'auth/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': 'test999126@test.com',
      'password': 'Password123!'
    })
  );
  print('Login Response: ${loginRes.statusCode} - ${loginRes.body}');
  
  if (loginRes.statusCode == 200) {
    final token = jsonDecode(loginRes.body)['token']; 
    print('Token: $token');
    
    print('Fetching products...');
    final prodRes = await http.get(
      Uri.parse(baseUrl + 'product?page=1'),
      headers: {'Authorization': 'Bearer $token'}
    );
    print('Product Response: ${prodRes.statusCode}');
    if (prodRes.statusCode == 200) {
      final json = jsonDecode(prodRes.body);
      print('Keys in response: ${json.keys.toList()}');
      if (json.containsKey('data')) {
        final data = json['data'];
        if (data is List && data.isNotEmpty) {
          print('First product: ${data[0]}');
        } else {
          print('Data is empty or not a list: $data');
        }
      } else {
         print('No data key. Whole body: ${prodRes.body}');
      }
    } else {
      print('Failed to fetch products: ${prodRes.body}');
    }
  }
}
