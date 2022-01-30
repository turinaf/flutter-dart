import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String messsage;
  final bool isMe;
  final Key key;
  final String userName;
  MessageBubble(
    this.messsage,
    this.userName,
    this.isMe,
    this.key,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: !isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
                bottomRight:
                    isMe ? const Radius.circular(0) : const Radius.circular(12),
              ),
            ),
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // FutureBuilder(
                //   future: Future.value(FirebaseFirestore.instance
                //       .collection('users')
                //       .doc(userId)
                //       .get()),
                //   builder: (ctx, AsyncSnapshot futureSnapshot) {
                //     if (futureSnapshot.connectionState ==
                //         ConnectionState.waiting) {
                //       return const Text("Loading..");
                //     }
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline1!.color,
                  ),
                ),
                Text(
                  messsage,
                  style: TextStyle(
                    color: isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline1!.color,
                  ),
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
              ],
            )),
      ],
    );
  }
}
