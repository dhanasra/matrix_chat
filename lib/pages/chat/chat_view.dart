import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/pages/chat/chat_viewmodel.dart';
import 'package:instrive_chat/pages/chat/widgets/chat_item.dart';
import 'package:instrive_chat/widgets/chat_input_field.dart';
import 'package:matrix/matrix.dart';

import '../../bloc/chat/chat_bloc.dart';

class ChatView extends StatefulWidget {
  final String roomId;
  const ChatView({
    super.key,
    required this.roomId  
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ChatViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ChatViewModel();
    _viewModel.start();
    context.read<ChatBloc>().add(RequestMessageEvent(roomId: widget.roomId));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (_, state){

                return ChatListBuilder(
                  isLoading: state is MessageReceivedLoading,
                  events: state is MessageReceivedSuccess ? state.messages : [],
                );
              }
            )
          ),
          ChatInputField(
            viewModel: _viewModel,
          )
        ],
      ),
    );
  }
}

class ChatListBuilder extends StatelessWidget {
  final List<Event> events;
  final bool isLoading;
  const ChatListBuilder({
    super.key,
    required this.events,
    required this.isLoading  
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: isLoading ? 1 : events.length,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemBuilder: (_, index){
          return isLoading
              ? const CircularProgressIndicator()
              : events[index].type=="m.room.message"
              ? ChatItem(event: events[index])
              : const SizedBox.shrink();
        },
    );
  }
}