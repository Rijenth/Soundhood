class Conversation {
  final String id;
  final List<String> participantIds;

  Conversation({required this.id, required this.participantIds});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
    id: json['id'].toString(),
    participantIds: List<String>.from(json['participants'].map((x) => x['id'].toString())),
    );
  }
}