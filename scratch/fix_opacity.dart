import 'dart:io';

void main() async {
  final dir = Directory('lib');
  final files = await dir.list(recursive: true).toList();
  
  for (var entity in files) {
    if (entity is File && entity.path.endsWith('.dart')) {
      String content = await entity.readAsString();
      
      // Fix .color.withOpacity
      String newContent = content.replaceAll(
        '?.color.withOpacity', 
        '?.color ?? Colors.black).withOpacity'
      );
      
      // Since we added a closing parenthesis, we need an opening one before Theme.of
      // e.g., Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity
      // We must replace 'Theme.of(context)' with '(Theme.of(context)' if it's followed by .withOpacity
      
      // Safer: Let's do it with regex
      newContent = content.replaceAllMapped(
        RegExp(r'Theme\.of\(([^)]+)\)\.textTheme\.([^?]+)\?\.color\.withOpacity\(([^)]+)\)'),
        (match) => '(Theme.of(${match.group(1)}).textTheme.${match.group(2)}?.color ?? Colors.black).withOpacity(${match.group(3)})'
      );

      // Also fix address_info_step const SectionHeader
      if (entity.path.endsWith('address_info_step.dart')) {
        newContent = newContent.replaceAll('const SectionHeader', 'SectionHeader');
      }

      // Fix store_info_step flutter_screenutil import
      if (entity.path.endsWith('store_info_step.dart')) {
        if (!newContent.contains('flutter_screenutil')) {
          newContent = "import 'package:flutter_screenutil/flutter_screenutil.dart';\n" + newContent;
        }
      }

      // Fix legal_policies undefined context
      if (entity.path.endsWith('legal_policies.dart')) {
         newContent = newContent.replaceAll(
           'Widget _buildPolicyItem(String title) {', 
           'Widget _buildPolicyItem(BuildContext context, String title) {'
         );
         newContent = newContent.replaceAll(
           "_buildPolicyItem('Terms of Service')", 
           "_buildPolicyItem(context, 'Terms of Service')"
         );
         newContent = newContent.replaceAll(
           "_buildPolicyItem('Privacy Policy')", 
           "_buildPolicyItem(context, 'Privacy Policy')"
         );
         newContent = newContent.replaceAll(
           "_buildPolicyItem('Return Policy')", 
           "_buildPolicyItem(context, 'Return Policy')"
         );
      }

      if (content != newContent) {
        await entity.writeAsString(newContent);
        print('Fixed \${entity.path}');
      }
    }
  }
}
