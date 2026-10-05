import 'package:flutter_test/flutter_test.dart';

import 'package:dismissible_demo/main.dart';

void main() {
  testWidgets('Inbox shows the list of emails', (WidgetTester tester) async {
    await tester.pumpWidget(const DismissibleDemoApp());

    expect(find.text('Inbox (8)'), findsOneWidget);
    expect(find.text('Canvas'), findsOneWidget);
  });
}
