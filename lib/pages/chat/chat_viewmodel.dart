import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/bloc/chat/chat_bloc.dart';
import 'package:instrive_chat/pages/base/base_view_model.dart';

class ChatViewModel extends BaseViewModel{

  ChatViewModel._internal();
  static final ChatViewModel _chatViewModel = ChatViewModel._internal();
  factory ChatViewModel(){
    return _chatViewModel;
  }

  late TextEditingController textMessageController;

  String? roomId;

  @override
  void start() {
    textMessageController = TextEditingController();
  }

  void sendTextMessage(BuildContext context){

    if(textMessageController.text.isEmpty){
      return;
    }

    context.read<ChatBloc>().add(
      SendText(
        message: textMessageController.text, 
        roomId: roomId!
      )
    );
  }


  @override
  void dispose() {
    textMessageController.dispose();
  }

}