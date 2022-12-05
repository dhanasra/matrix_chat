import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instrive_chat/config/matrix.dart';
import 'package:matrix/matrix.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendText>(onSendText);
    on<RequestMessageEvent>(onRequestMessages);
    on<MessageReceivedEvent>(onMessageReceived);
  }

  void onRequestMessages(RequestMessageEvent event, Emitter emit) async{
    emit(MessageReceivedLoading());

    await AppMatrix.client.roomsLoading;
    await AppMatrix.client.accountDataLoading;
    var room = AppMatrix.client.getRoomById(event.roomId);
    var timeline = await room!.getTimeline();
    await timeline.getRoomEvents();
    var events = timeline.events;
    add(MessageReceivedEvent(messages: events));

    room.onUpdate.stream.listen((event) {
      var events = timeline.events;
      add(MessageReceivedEvent(messages: events));
    });
  }

  void onMessageReceived(MessageReceivedEvent event, Emitter emit){
    emit(MessageReceivedSuccess(messages: event.messages));
  }


  void onSendText(SendText event, Emitter emit)async{

    var room = AppMatrix.client.getRoomById(event.roomId);
    await room!.sendTextEvent(event.message);

    emit(MessageSent());
  }

}

