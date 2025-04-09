class Message {
  final String id;
  final String content;
  final String conversationId;
  final String senderId;

  Message({
  required this.id,
  required this.content,
  required this.conversationId,
  required this.senderId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
    id: json['id'].toString(),
    content: json['content'],
    conversationId: json['conversation_id'].toString(),
    senderId: json['sender_id'].toString(),
    );
  }
}