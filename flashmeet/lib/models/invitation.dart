enum InvitationStatus {
  inRequest,
  accepted,
  ignored,
}

class Invitation {
  final String id;
  final String userId;
  final String flashMeetId;
  final String attendeesId;
  final InvitationStatus status;

  Invitation({
    required this.id,
    required this.userId,
    required this.flashMeetId,
    required this.attendeesId,
    required this.status,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      flashMeetId: json['flash_meet_id'] as String,
      attendeesId: json['attendees_id'] as String,
      status: InvitationStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => InvitationStatus.inRequest,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'flash_meet_id': flashMeetId,
      'attendees_id': attendeesId,
      'status': status.name,
    };
  }
}

