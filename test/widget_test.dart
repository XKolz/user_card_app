import 'package:flutter_test/flutter_test.dart';

import 'package:user_card_app/app.dart';

void main() {
  testWidgets('app renders main account screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('My Account'), findsOneWidget);
    expect(find.text('Quick Actions'), findsOneWidget);
  });
}
