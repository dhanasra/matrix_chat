import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instrive_chat/config/matrix.dart';
import 'package:matrix/matrix.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendText>(onSendText);
    on<GetChatEvents>(onGetChatEvents);
  }

  void onGetChatEvents(GetChatEvents event, Emitter emit) async {
    emit(ChatEventsLoading());

    await AppMatrix.client.roomsLoading;
    await AppMatrix.client.accountDataLoading;
    var room = AppMatrix.client.getRoomById(event.roomId);
    var timeline = await room!.getTimeline();
    await timeline.getRoomEvents();
    var events = timeline.events;

    emit(ChatEventsFetched(events: events));
  }



  void onSendText(SendText event, Emitter emit)async{

    var room = AppMatrix.client.getRoomById(event.roomId);
    await room!.sendTextEvent(event.message);

    emit(MessageSent());
  }

}

