import 'package:flutter_test/flutter_test.dart';
import 'package:act15_mad/main.dart';

void main() {
  testWidgets('Inventory app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(InventoryApp());
    expect(find.text('Inventory Management System'), findsOneWidget);
  });
}
