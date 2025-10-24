enum RequestStatus {
  inRequest,
  accepted,
  refused,
}

class Request {
  final String userId;
  final String flashMeetId;
  final RequestStatus status;

  Request({
    required this.userId,
    required this.flashMeetId,
    required this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      userId: json['user_id'] as String,
      flashMeetId: json['flash_meet_id'] as String,
      status: RequestStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RequestStatus.inRequest,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'flash_meet_id': flashMeetId,
      'status': status.name,
    };
  }
}

