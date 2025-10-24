enum RelationStatus {
  friends,
  block,
  inRequest,
  ignored,
}

class Relation {
  final String user1Id;
  final String user2Id;
  final RelationStatus status;
  final DateTime dateTime;

  Relation({
    required this.user1Id,
    required this.user2Id,
    required this.status,
    required this.dateTime,
  });

  factory Relation.fromJson(Map<String, dynamic> json) {
    return Relation(
      user1Id: json['user1_id'] as String,
      user2Id: json['user2_id'] as String,
      status: RelationStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RelationStatus.inRequest,
      ),
      dateTime: DateTime.parse(json['date_time'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user1_id': user1Id,
      'user2_id': user2Id,
      'status': status.name,
      'date_time': dateTime.toIso8601String(),
    };
  }
}

