enum InvitationType {
  owner,
  friends,
  attendees,
}

class FlashMeet {
  final String id;
  final String title;
  final DateTime startDate;
  final int duration; // durée en minutes
  final DateTime endDate;
  final String localization;
  final String organizerId;
  final int maxAttendees;
  final InvitationType typeInvitation;

  FlashMeet({
    required this.id,
    required this.title,
    required this.startDate,
    required this.duration,
    required this.endDate,
    required this.localization,
    required this.organizerId,
    required this.maxAttendees,
    required this.typeInvitation,
  });

  factory FlashMeet.fromJson(Map<String, dynamic> json) {
    return FlashMeet(
      id: json['id'] as String,
      title: json['title'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      duration: json['duration'] as int,
      endDate: DateTime.parse(json['end_date'] as String),
      localization: json['localization'] as String,
      organizerId: json['organizer'] as String,
      maxAttendees: json['max_attendees'] as int,
      typeInvitation: InvitationType.values.firstWhere(
        (e) => e.name == json['type_invitation'],
        orElse: () => InvitationType.owner,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate.toIso8601String(),
      'duration': duration,
      'end_date': endDate.toIso8601String(),
      'localization': localization,
      'organizer': organizerId,
      'max_attendees': maxAttendees,
      'type_invitation': typeInvitation.name,
    };
  }
}