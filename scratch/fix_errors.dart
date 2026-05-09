import 'dart:io';

void main() async {
  final dir = Directory('lib');
  final files = await dir.list(recursive: true).toList();
  
  for (var entity in files) {
    if (entity is File && entity.path.endsWith('.dart')) {
      String content = await entity.readAsString();
      String newContent = content;

      // 1. Remove const before any widget that has .tr() inside
      // A quick regex to replace "const Something( ... .tr() ... )" is hard across multiple lines.
      // But we can remove 'const ' if the line has .tr()
      // Let's do it line by line
      List<String> lines = newContent.split('\n');
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].contains('.tr()') && lines[i].contains('const ')) {
          lines[i] = lines[i].replaceAll('const ', '');
        }
      }
      newContent = lines.join('\n');

      // 2. legal_policies.dart undefined context
      if (entity.path.endsWith('legal_policies.dart')) {
        // My previous fix failed? Let's check
        newContent = newContent.replaceAll(
          'Widget _buildPolicyItem(String title)',
          'Widget _buildPolicyItem(BuildContext context, String title)'
        );
        newContent = newContent.replaceAll(
          "_buildPolicyItem('terms_of_service'.tr())",
          "_buildPolicyItem(context, 'terms_of_service'.tr())"
        );
        newContent = newContent.replaceAll(
          "_buildPolicyItem('privacy_policy'.tr())",
          "_buildPolicyItem(context, 'privacy_policy'.tr())"
        );
        newContent = newContent.replaceAll(
          "_buildPolicyItem('return_policy'.tr())",
          "_buildPolicyItem(context, 'return_policy'.tr())"
        );
      }

      // 3. store_analytics.dart undefined context
      if (entity.path.endsWith('store_analytics.dart')) {
        newContent = newContent.replaceAll(
          'Widget _buildStatItem(String label, String value, String trend, bool isPositive)',
          'Widget _buildStatItem(BuildContext context, String label, String value, String trend, bool isPositive)'
        );
        newContent = newContent.replaceAllMapped(
          RegExp(r'_buildStatItem\(([^,]+),\s*([^,]+),\s*([^,]+),\s*([^)]+)\)'),
          (m) {
            // Check if it already has context
            if (m.group(1) == 'context') return m.group(0)!;
            return '_buildStatItem(context, \${m.group(1)}, \${m.group(2)}, \${m.group(3)}, \${m.group(4)})';
          }
        );
      }

      // 4. products.dart argument type Color?
      if (entity.path.endsWith('products.dart')) {
        newContent = newContent.replaceAll(
          'Theme.of(context).textTheme.bodyLarge?.color,',
          'Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,'
        );
      }

      // Fix specific multi-line const errors
      if (entity.path.endsWith('reset_password.dart')) {
        newContent = newContent.replaceAll('const CustomTextField(', 'CustomTextField(');
      }
      if (entity.path.endsWith('pricing_stock_section.dart')) {
        newContent = newContent.replaceAll('const AddProductTextField(', 'AddProductTextField(');
      }
      if (entity.path.endsWith('product_details_section.dart')) {
        newContent = newContent.replaceAll('const AddProductTextField(', 'AddProductTextField(');
      }
      if (entity.path.endsWith('seo_visibility_section.dart')) {
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
