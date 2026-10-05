import 'package:flutter/material.dart';

import 'screens/inbox_screen.dart';

void main() {
  runApp(const DismissibleDemoApp());
}

class DismissibleDemoApp extends StatelessWidget {
  const DismissibleDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dismissible Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const InboxScreen(),
    );
  }
}
