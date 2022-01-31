import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String messsage;
  final String userName;
  final bool isMe;
  final String imag_url;
  final Key key;

  const MessageBubble(
    this.messsage,
    this.userName,
    this.imag_url,
    this.isMe,
    this.key,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: !isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 38),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // -- Displying name of the other user.
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 10,
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                  ),

                  // -- Diplaying the message, with different stley for the other user.
                  Text(
                    messsage,
                    style: TextStyle(
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 45,
          left: isMe ? null : 2,
          right: isMe ? 2 : null,
          child: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(imag_url),
          ),
        ),
      ],
    );
  }
}
