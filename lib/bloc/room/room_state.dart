part of 'room_bloc.dart';

@immutable
abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomsLoading extends RoomState {}

class StoriesLoading extends RoomState {}

class ChatRoomsFetched extends RoomState {
  final List<Room> rooms;

  ChatRoomsFetched({
    required this.rooms
  });
}

class StoriesFetched extends RoomState {
  final List<Room> stories;

  StoriesFetched({
    required this.stories
  });
}
