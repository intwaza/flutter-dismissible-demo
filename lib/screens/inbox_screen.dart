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

  /// Called after an email has been swiped away.
  void _onEmailDismissed(int index) {
    final removed = _emails[index];

    // Remove the item from our data right away. Dismissible requires this:
    // the swiped widget must leave the tree, or Flutter throws an error.
    setState(() => _emails.removeAt(index));

    // Give the user a way to change their mind, like Gmail does.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Removed "${removed.subject}"'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(() => _emails.insert(index, removed)),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inbox (${_emails.length})')),
      body: ListView.separated(
        itemCount: _emails.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final email = _emails[index];

          // Dismissible makes its child swipeable. All optional properties
          // are left at their defaults for now.
          return Dismissible(
            // The key must be unique and stable, so Flutter knows exactly
            // which email was swiped (never use the index here).
            key: ValueKey(email.id),
            onDismissed: (direction) => _onEmailDismissed(index),
            child: EmailTile(email: email),
          );
        },
      ),
    );
  }
}
