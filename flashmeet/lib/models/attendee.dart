class Attendee {
  final String flashMeetId;
  final String userId;

  Attendee({
    required this.flashMeetId,
    required this.userId,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      flashMeetId: json['flash_meet_id'] as String,
      userId: json['user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flash_meet_id': flashMeetId,
      'user_id': userId,
    };
  }
}

