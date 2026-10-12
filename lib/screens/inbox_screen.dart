import 'package:flutter/material.dart';

import '../data/sample_emails.dart';
import '../models/dismiss_settings.dart';
import '../models/email.dart';
import '../widgets/email_tile.dart';
import '../widgets/settings_panel.dart';
import '../widgets/swipe_background.dart';

/// The inbox: a scrollable list of emails.
class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  // A copy of the sample data, so we can remove items later.
  final List<Email> _emails = List.of(sampleEmails);

  // The values used for the three demo properties, changed by the panel.
  DismissSettings _settings = const DismissSettings();
  bool _showSettings = false;

  /// Called after an email has been swiped away.
  /// [direction] tells us which way it was swiped, so we know the action.
  void _onEmailDismissed(int index, DismissDirection direction) {
    final removed = _emails[index];
    final action =
        direction == DismissDirection.startToEnd ? 'Archived' : 'Deleted';

    // Remove the item from our data right away. Dismissible requires this:
    // the swiped widget must leave the tree, or Flutter throws an error.
    setState(() => _emails.removeAt(index));

    // Give the user a way to change their mind, like Gmail does.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$action "${removed.subject}"'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(() => _emails.insert(index, removed)),
          ),
        ),
      );
  }

  /// Puts all sample emails back, so the demo never runs out of items.
  void _resetInbox() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      _emails
        ..clear()
        ..addAll(sampleEmails);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox (${_emails.length})'),
        actions: [
          IconButton(
            tooltip: 'Reset inbox',
            icon: const Icon(Icons.refresh),
            onPressed: _resetInbox,
          ),
          IconButton(
            tooltip: 'Dismissible settings',
            icon: Icon(_showSettings ? Icons.close : Icons.tune),
            onPressed: () => setState(() => _showSettings = !_showSettings),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildEmailList()),
          if (_showSettings)
            SettingsPanel(
              settings: _settings,
              onChanged: (settings) => setState(() => _settings = settings),
            ),
        ],
      ),
    );
  }

  Widget _buildEmailList() {
    return ListView.separated(
      itemCount: _emails.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final email = _emails[index];

        // Dismissible makes its child swipeable.
        return Dismissible(
          // The key must be unique and stable, so Flutter knows exactly
          // which email was swiped (never use the index here).
          key: ValueKey(email.id),

          // PROPERTY 1: direction (default: DismissDirection.horizontal).
          // Restricts which way(s) the user can swipe.
          direction: _settings.direction,

          // PROPERTY 2: background (default: null = empty space).
          // Shown when swiping left to right (startToEnd) -> Archive.
          background: _settings.showBackgrounds
              ? const SwipeBackground(
                  color: Colors.green,
                  icon: Icons.archive,
                  label: 'Archive',
                  alignment: Alignment.centerLeft,
                )
              : null,

          // Shown when swiping right to left (endToStart) -> Delete.
          // Only allowed if `background` is also set.
          secondaryBackground: _settings.showBackgrounds
              ? const SwipeBackground(
                  color: Colors.red,
                  icon: Icons.delete,
                  label: 'Delete',
                  alignment: Alignment.centerRight,
                )
              : null,

          // PROPERTY 3: dismissThresholds (default: 0.4 = 40% of the width).
          // How far the user must drag before letting go dismisses the item.
          dismissThresholds: {
            DismissDirection.startToEnd: _settings.threshold,
            DismissDirection.endToStart: _settings.threshold,
          },

          onDismissed: (direction) => _onEmailDismissed(index, direction),
          child: EmailTile(email: email),
        );
      },
    );
  }
}
