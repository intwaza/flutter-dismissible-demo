import '../models/email.dart';

/// Fake inbox data so the demo works without a backend.
const List<Email> sampleEmails = [
  Email(
    id: '1',
    sender: 'Canvas',
    subject: 'New assignment: Widget Presentation',
    preview: 'Your in-class demo is due before 5:00 PM on the day you present.',
    time: '9:41 AM',
    isUnread: true,
  ),
  Email(
    id: '2',
    sender: 'GitHub',
    subject: 'Your repository is now public',
    preview: 'flutter-dismissible-demo is visible to everyone.',
    time: '9:12 AM',
    isUnread: true,
  ),
  Email(
    id: '3',
    sender: 'Study Group',
    subject: 'Meeting moved to Thursday',
    preview: 'Same room, 4 PM. Bring your laptops for the Flutter practice.',
    time: '8:30 AM',
  ),
  Email(
    id: '4',
    sender: 'MTN MoMo',
    subject: 'Transaction receipt',
    preview: 'You have received 5,000 RWF. Your new balance is available.',
    time: 'Yesterday',
  ),
  Email(
    id: '5',
    sender: 'Newsletter',
    subject: 'This week in Flutter',
    preview: 'New widgets, performance tips and community highlights.',
    time: 'Yesterday',
  ),
  Email(
    id: '6',
    sender: 'Library',
    subject: 'Book due in 3 days',
    preview: 'Please return "Flutter in Action" or renew it online.',
    time: 'Mon',
  ),
  Email(
    id: '7',
    sender: 'Campus Events',
    subject: 'Hackathon registration open',
    preview: 'Form a team of up to four and build something in 24 hours.',
    time: 'Sun',
  ),
  Email(
    id: '8',
    sender: 'Promotions',
    subject: '50% off headphones this weekend',
    preview: 'Limited stock. Offer ends Sunday at midnight.',
    time: 'Sat',
  ),
];
