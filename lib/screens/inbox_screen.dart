import 'package:flutter/material.dart';

import '../data/sample_emails.dart';
import '../models/email.dart';
import '../widgets/email_tile.dart';

/// The inbox: a scrollable list of emails.
class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  // A copy of the sample data, so we can remove items later.
  final List<Email> _emails = List.of(sampleEmails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inbox (${_emails.length})')),
      body: ListView.separated(
        itemCount: _emails.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) => EmailTile(email: _emails[index]),
      ),
    );
  }
}
