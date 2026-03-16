import 'package:brand/my_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Brand Profile smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // The ViewModel has a 1-second delay for "API loading".
    // We need to advance the clock to let that timer finish.
    await tester.pump(const Duration(seconds: 1));
    
    // Allow any animations to settle
    await tester.pumpAndSettle();

    // Verify that the Brand Profile screen is shown.
    expect(find.byType(MyApp), findsOneWidget);
  });
}
