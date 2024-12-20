
class MessageModel {
  final String message;
  final MessageType type;
  MessageModel({
    required this.message,
    required this.type,
  });
}

enum MessageType {
  error,
  success,
  info
}