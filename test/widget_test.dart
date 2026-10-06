import 'package:flutter_test/flutter_test.dart';

import 'package:dismissible_demo/main.dart';

void main() {
  testWidgets('Inbox shows the list of emails', (WidgetTester tester) async {
    await tester.pumpWidget(const DismissibleDemoApp());

    expect(find.text('Inbox (8)'), findsOneWidget);
    expect(find.text('Canvas'), findsOneWidget);
  });

  testWidgets('Swiping an email removes it and Undo brings it back',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DismissibleDemoApp());

    await tester.drag(find.text('Canvas'), const Offset(-600, 0));
    await tester.pumpAndSettle();

    expect(find.text('Canvas'), findsNothing);
    expect(find.text('Inbox (7)'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();

    expect(find.text('Canvas'), findsOneWidget);
    expect(find.text('Inbox (8)'), findsOneWidget);
  });
}
