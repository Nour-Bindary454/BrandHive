import 'dart:io';

void main() async {
  List<String> files = [
    'lib/features/seller/add/widgets/pricing_stock_section.dart',
    'lib/features/seller/add/widgets/product_details_section.dart',
    'lib/features/seller/add/widgets/shipping_info_section.dart'
  ];

  for (String file in files) {
    File f = File(file);
    if (await f.exists()) {
      String c = await f.readAsString();
      // Remove const Expanded
      c = c.replaceAll('const Expanded(', 'Expanded(');
      // Remove const AddProductTextField
      c = c.replaceAll('const AddProductTextField(', 'AddProductTextField(');
      await f.writeAsString(c);
      print('Fixed \$file');
    }
  }
}
