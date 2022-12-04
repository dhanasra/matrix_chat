part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class MessageSent extends ChatState {}

class ChatEventsLoading extends ChatState {}

class ChatEventsFetched extends ChatState {
  final List<Event> events;

  ChatEventsFetched({
    required this.events
  });
}
