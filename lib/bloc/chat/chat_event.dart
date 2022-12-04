part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class GetChatEvents extends ChatEvent {
  final String roomId;

  GetChatEvents({
    required this.roomId
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