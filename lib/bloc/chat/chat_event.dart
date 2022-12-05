part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class RequestMessageEvent extends ChatEvent {
  final String roomId;

  RequestMessageEvent({
    required this.roomId
  });
}

class MessageReceivedEvent extends ChatEvent {
  final List<Event> messages;
  MessageReceivedEvent({
    required this.messages
  });
}

class SendText extends ChatEvent{
  final String message;
  final String roomId;

  SendText({
    required this.message,
    required this.roomId
  });
}