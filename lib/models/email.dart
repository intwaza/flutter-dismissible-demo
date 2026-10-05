/// A single message shown in the inbox.
class Email {
  const Email({
    required this.id,
    required this.sender,
    required this.subject,
    required this.preview,
    required this.time,
    this.isUnread = false,
  });

  /// Unique id. Dismissible needs a unique key per item, so we build it from this.
  final String id;
  final String sender;
  final String subject;
  final String preview;
  final String time;
  final bool isUnread;
}
