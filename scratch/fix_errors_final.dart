import 'dart:io';

void main() async {
  final dir = Directory('lib');
  final files = await dir.list(recursive: true).toList();
  
  for (var entity in files) {
    if (entity is File && entity.path.endsWith('.dart')) {
      String content = await entity.readAsString();
      String newContent = content;

      if (entity.path.endsWith('store_analytics.dart') || entity.path.endsWith('legal_policies.dart')) {
        if (!newContent.contains('easy_localization.dart')) {
          newContent = "import 'package:easy_localization/easy_localization.dart';\n" + newContent;
        }
      }

      // Replace argument_type_not_assignable for Color?
      newContent = newContent.replaceAll(
        'Theme.of(context).textTheme.bodyLarge?.color,',
        'Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,'
      );
      newContent = newContent.replaceAll(
        'Theme.of(context).textTheme.bodyMedium?.color,',
        'Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey,'
      );

      // Replace const errors in specific files
      if (entity.path.endsWith('reset_password.dart')) {
        newContent = newContent.replaceAll('const CustomTextField(', 'CustomTextField(');
      }
      if (entity.path.endsWith('pricing_stock_section.dart')) {
        newContent = newContent.replaceAll('const AddProductTextField(', 'AddProductTextField(');
      }
      if (entity.path.endsWith('product_details_section.dart')) {
        newContent = newContent.replaceAll('const AddProductTextField(', 'AddProductTextField(');
      }
      if (entity.path.endsWith('shipping_info_section.dart')) {
        newContent = newContent.replaceAll('const AddProductTextField(', 'AddProductTextField(');
      }

      if (content != newContent) {
        await entity.writeAsString(newContent);
        print('Fixed \${entity.path}');
      }
    }
  }
}
