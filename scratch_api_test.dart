import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  try {
    final response = await http.get(Uri.parse('http://192.168.1.5:3000/api/v1/brand?status=pending'));
    final data = json.decode(response.body);
    if (data['data'] != null && data['data'].isNotEmpty) {
      print(const JsonEncoder.withIndent('  ').convert(data['data'][0]));
    } else {
      print('No pending brands found');
    }
  } catch (e) {
    print(e);
  }
}
