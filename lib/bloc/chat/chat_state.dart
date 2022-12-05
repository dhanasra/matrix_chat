part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class MessageSent extends ChatState {}

class MessageReceivedLoading extends ChatState {}

class MessageReceivedSuccess extends ChatState {
  final List<Event> messages;

  MessageReceivedSuccess({
    required this.messages
  });
}
