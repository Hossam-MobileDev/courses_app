import '../../../../common/entities/message.dart';

class MessageStates {
  const MessageStates(
      {this.message = const <Message>[], this.loadStatus = true});

  final List<Message> message;
  final bool loadStatus;

  MessageStates copyWith({List<Message>? message, bool? loadStatus}) {
    return MessageStates(
        message: message ?? this.message,
        loadStatus: loadStatus ?? this.loadStatus);
  }
}
