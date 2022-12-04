import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instrive_chat/config/matrix.dart';
import 'package:matrix/matrix.dart';
part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitial()) {
    on<GetChatRooms>(onGetChatRooms);
    on<GetStories>(onGetStories);
  }

  void onGetChatRooms(GetChatRooms event, Emitter emit) async{ 
    emit(RoomsLoading());
    final rooms = AppMatrix.client.rooms.where((room)=>room.isDirectChat).toList();
    emit(ChatRoomsFetched(rooms: rooms));
    add(GetStories());
  }

  void onGetStories(GetStories event, Emitter emit) async{
    emit(StoriesLoading());
    final stories = AppMatrix.client.rooms.where((room)
      =>room.getState(EventTypes.RoomCreate)?.content.tryGet<String>('type')=='msc3588.stories.stories-room').toList();
    emit(StoriesFetched(stories: stories));
  }

}
