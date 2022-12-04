import 'package:flutter/material.dart';
import 'package:instrive_chat/pages/chat/chat_viewmodel.dart';

class ChatInputField extends StatelessWidget {
  final ChatViewModel viewModel;

  const ChatInputField({
    super.key,
    required this.viewModel  
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          
          Expanded(
          child: TextFormField(
            maxLines: 3,
            minLines: 1,
            controller: viewModel.textMessageController,
            decoration: InputDecoration(
              filled: true,
              hintText: "Write a message...",
              suffixIcon: Wrap(
                children: [
                  IconButton(
                    onPressed: (){}, 
                    icon: const Icon(Icons.add),
                    splashRadius: 22,  
                  ),

                  IconButton(
                    onPressed: (){}, 
                    icon: const Icon(Icons.emoji_emotions),
                    splashRadius: 22,  
                  ),
                  
                  const SizedBox(width: 8,),
                ],
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8)
              ),
            ),
            style: const TextStyle(
              height: 1.5
            ),
          )),

          const SizedBox(width: 14,),

          FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: ()=>viewModel.sendTextMessage(context),
            elevation: 0,
            child: const Icon(Icons.send, color: Colors.black, size: 20,),
          )
        ],
      ),
    );
  }
}