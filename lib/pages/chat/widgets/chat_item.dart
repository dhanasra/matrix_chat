import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instrive_chat/config/matrix.dart';
import 'package:matrix/matrix.dart';

class ChatItem extends StatelessWidget {
  final Event event;
  const ChatItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var isMe = event.senderId==AppMatrix.client.userID!;

    return  Container(
      margin: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!isMe) const Padding(
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.amber,
            ),
          ),
          Stack(
            children: [
              Positioned(
                bottom: 0,
                right: isMe ? 0 : null,
                child: Transform(
                  transform: Matrix4.rotationY(isMe ? pi : 0),
                  child: CustomPaint(
                    painter: ChatBubbleTriangle(color: isMe ? Colors.amber : Theme.of(context).canvasColor),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(minWidth: 50, maxWidth: 300),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.amber : Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(event.body)
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubbleTriangle extends CustomPainter {

  final Color color;

  ChatBubbleTriangle({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var path = Path();
    path.lineTo(-10, 0);
    path.quadraticBezierTo(10, -10, 5, -30);
    path.lineTo(10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
