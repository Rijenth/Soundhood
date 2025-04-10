class Message {
  final String id;
  final String content;
  final String conversationId;
  final String userId;

  Message({
  required this.id,
  required this.content,
  required this.conversationId,
  required this.userId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
    id: json['id'].toString(),
    content: json['content'],
    conversationId: json['conversation_id'].toString(),
    userId: json['user_id'].toString(),
    );
  }

  @override
  String toString() {
    return 'Message(id: $id, content: "$content", conversationId: $conversationId, user_id: $userId)';
  }
}