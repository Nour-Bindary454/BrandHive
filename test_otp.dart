import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final baseUrl = 'https://brandhive-apis-production.up.railway.app/';
  final email = 'test_user_${DateTime.now().millisecondsSinceEpoch}@test.com';
  final password = 'Password123!';

  print('Registering $email...');
  final regRes = await http.post(
    Uri.parse(baseUrl + 'auth/register'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': 'Test User',
      'email': email,
      'password': password,
      'confirmPassword': password
    })
  );
  print('Reg Response: ${regRes.statusCode} - ${regRes.body}');

  if (regRes.statusCode == 201 || regRes.statusCode == 200) {
    // Try some common OTPs
    final otps = ['123456', '000000', '111111', '12345'];
    for (final otp in otps) {
      print('Trying OTP: $otp...');
      final confirmRes = await http.post(
        Uri.parse(baseUrl + 'auth/confirm-email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp})
      );
      print('Confirm Response: ${confirmRes.statusCode} - ${confirmRes.body}');
      if (confirmRes.statusCode == 200) {
        print('SUCCESS! Verified with OTP: $otp');
        
        // Log in to get token
        final loginRes = await http.post(
          Uri.parse(baseUrl + 'auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password})
        );
        print('Login Response: ${loginRes.statusCode} - ${loginRes.body}');
        return;
      }
    }
  }
}
