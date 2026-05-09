import 'dart:io';

void main() async {
  // Fix toast.dart
  File toastFile = File('lib/core/utils/toast/toast.dart');
  if (await toastFile.exists()) {
    String content = await toastFile.readAsString();
    content = content.replaceAll('const Text(', 'Text(');
    await toastFile.writeAsString(content);
    print('Fixed toast.dart');
  }

  // Fix product_card.dart
  File productCardFile = File('lib/features/brand_profile/presentation/widgets/product_card.dart');
  if (await productCardFile.exists()) {
    String content = await productCardFile.readAsString();
    content = content.replaceAll(
      'Theme.of(context).textTheme.bodyLarge?.color.withValues',
      '(Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity'
    );
    await productCardFile.writeAsString(content);
    print('Fixed product_card.dart');
  }

  // Fix order_summary_widget.dart
  File orderSummaryFile = File('lib/features/cart/presentation/widgets/order_summary_widget.dart');
  if (await orderSummaryFile.exists()) {
    String content = await orderSummaryFile.readAsString();
    content = content.replaceAll(
      'Widget _buildSummaryRow(String label, String value, {bool isTotal = false})',
      'Widget _buildSummaryRow(BuildContext context, String label, String value, {bool isTotal = false})'
    );
    content = content.replaceAllMapped(
      RegExp(r'_buildSummaryRow\(([^,)]+),\s*([^,)]+)(?:,\s*isTotal:\s*([^)]+))?\)'),
      (m) {
        if (m.group(1) == 'context') return m.group(0)!;
        String args = 'context, \${m.group(1)}, \${m.group(2)}';
        if (m.group(3) != null) args += ', isTotal: \${m.group(3)}';
        return '_buildSummaryRow(\$args)';
      }
    );
    await orderSummaryFile.writeAsString(content);
    print('Fixed order_summary_widget.dart');
  }

  // Fix checkout_screen.dart
  File checkoutFile = File('lib/features/checkout/presentation/views/checkout_screen.dart');
  if (await checkoutFile.exists()) {
    String content = await checkoutFile.readAsString();
    content = content.replaceAll('const CheckoutBottomBar(', 'CheckoutBottomBar(');
    await checkoutFile.writeAsString(content);
    print('Fixed checkout_screen.dart');
  }

  // Fix explore.dart
  File exploreFile = File('lib/features/explore/presentaion/views/explore.dart');
  if (await exploreFile.exists()) {
    String content = await exploreFile.readAsString();
    content = content.replaceAll('const BrowseAllCategories()', 'BrowseAllCategories()');
    await exploreFile.writeAsString(content);
    print('Fixed explore.dart');
  }

  // Fix featured_brands.dart
  File featuredBrandsFile = File('lib/features/explore/presentaion/views/widgets/featured_brands.dart');
  if (await featuredBrandsFile.exists()) {
    String content = await featuredBrandsFile.readAsString();
    content = content.replaceAll('color87', 'color');
    await featuredBrandsFile.writeAsString(content);
    print('Fixed featured_brands.dart');
  }
}
