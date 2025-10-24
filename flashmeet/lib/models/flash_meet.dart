import 'package:flashmeet/models/user.dart';

class FlashMeet {
  final int id;
  final String title;
  final DateTime startTime;
  final DateTime duration;
  final DateTime endTime;
  final String location;
  final User organizer;
  final List<User> attendees = [];
  final int maxAttendees;

  FlashMeet({
    required this.id,
    required this.title,
    required this.startTime,
    required this.duration,
    required this.endTime,
    required this.location,
    required this.organizer,
    required this.maxAttendees,
  });
}