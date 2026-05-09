import 'dart:io';

void main() async {
  List<String> files = [
    'lib/features/profile/presentation/views/widgets/stats_row.dart',
    'lib/features/resetPassword/view/reset_password.dart',
    'lib/features/seller/add/widgets/pricing_stock_section.dart',
    'lib/features/seller/add/widgets/product_details_section.dart',
    'lib/features/seller/add/widgets/shipping_info_section.dart',
    'lib/features/seller/overView/widgets/store_analytics.dart',
    'lib/features/seller/settings/widgets/legal_policies.dart',
  ];

  for (String filePath in files) {
    File file = File(filePath);
    if (!await file.exists()) continue;

    String content = await file.readAsString();
    String newContent = content;

    if (filePath.endsWith('stats_row.dart')) {
      newContent = newContent.replaceAll(
        'Widget _buildStatItem(String label, int value, IconData icon) {',
        'Widget _buildStatItem(BuildContext context, String label, int value, IconData icon) {'
      );
      newContent = newContent.replaceAllMapped(
        RegExp(r'_buildStatItem\(([^,]+),\s*([^,]+),\s*([^)]+)\)'),
        (m) {
          if (m.group(1) == 'context') return m.group(0)!;
          return '_buildStatItem(context, \${m.group(1)}, \${m.group(2)}, \${m.group(3)})';
        }
      );
      newContent = newContent.replaceAll(
        'Theme.of(context).cardColor',
        'Theme.of(context).cardColor' // Ensure it's correct
      );
      // Fix color assignability issue
      newContent = newContent.replaceAll(
        'color: Theme.of(context).cardColor,',
        'color: Theme.of(context).cardColor,'
      );
      // Wait, the error is: The argument type 'Color?' can't be assigned to the parameter type 'Color'.
      // It's probably related to text color or cardColor
      newContent = newContent.replaceAll(
        'Theme.of(context).textTheme.bodyLarge?.color,',
        'Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,'
      );
    }

    if (filePath.endsWith('reset_password.dart')) {
      newContent = newContent.replaceAll(
        'const CustomTextField(', 'CustomTextField(');
      newContent = newContent.replaceAll(
        'Theme.of(context).textTheme.bodyLarge?.color,',
        'Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,'
      );
    }

    if (filePath.endsWith('pricing_stock_section.dart') || 
        filePath.endsWith('product_details_section.dart') || 
        filePath.endsWith('shipping_info_section.dart')) {
      List<String> lines = newContent.split('\n');
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].contains('const AddProductTextField(')) {
          lines[i] = lines[i].replaceAll('const AddProductTextField(', 'AddProductTextField(');
        }
      }
      newContent = lines.join('\n');
    }

    if (filePath.endsWith('store_analytics.dart')) {
      newContent = newContent.replaceAll(
        'Widget _buildStatItem(String label, String value, String trend, bool isPositive)',
        'Widget _buildStatItem(BuildContext context, String label, String value, String trend, bool isPositive)'
      );
      newContent = newContent.replaceAllMapped(
        RegExp(r'_buildStatItem\(([^,]+),\s*([^,]+),\s*([^,]+),\s*([^)]+)\)'),
        (m) {
          if (m.group(1) == 'context') return m.group(0)!;
          return '_buildStatItem(context, \${m.group(1)}, \${m.group(2)}, \${m.group(3)}, \${m.group(4)})';
        }
      );
    }

    if (filePath.endsWith('legal_policies.dart')) {
      newContent = newContent.replaceAll(
        'Widget _buildPolicyItem(String title)',
        'Widget _buildPolicyItem(BuildContext context, String title)'
      );
      newContent = newContent.replaceAllMapped(
        RegExp(r'_buildPolicyItem\(([^,)]+)\)'),
        (m) {
          if (m.group(1)!.startsWith('context')) return m.group(0)!;
          return '_buildPolicyItem(context, \${m.group(1)})';
        }
      );
    }

    if (content != newContent) {
      await file.writeAsString(newContent);
      print('Fixed \$filePath');
    }
  }
}
