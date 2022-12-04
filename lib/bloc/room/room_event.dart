part of 'room_bloc.dart';

@immutable
abstract class RoomEvent {}

class GetChatRooms extends RoomEvent {}

class GetStories extends RoomEvent {}
