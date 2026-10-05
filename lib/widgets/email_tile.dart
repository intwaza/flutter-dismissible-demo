import 'package:flutter/material.dart';

import '../models/email.dart';

/// One row in the inbox: avatar, sender, subject, preview and time.
class EmailTile extends StatelessWidget {
  const EmailTile({super.key, required this.email});

  final Email email;

  @override
  Widget build(BuildContext context) {
    final fontWeight = email.isUnread ? FontWeight.bold : FontWeight.normal;

    return ListTile(
      leading: CircleAvatar(child: Text(email.sender[0])),
      title: Text(email.sender, style: TextStyle(fontWeight: fontWeight)),
      subtitle: Text(
        '${email.subject}\n${email.preview}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      isThreeLine: true,
      trailing: Text(email.time, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
