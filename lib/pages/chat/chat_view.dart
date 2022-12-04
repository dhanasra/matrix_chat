import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/pages/chat/chat_viewmodel.dart';
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
    context.read<ChatBloc>().add(GetChatEvents(roomId: widget.roomId));
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
                  isLoading: state is ChatEventsLoading,
                  events: state is ChatEventsFetched ? state.events : [],
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
    return Container();
  }
}