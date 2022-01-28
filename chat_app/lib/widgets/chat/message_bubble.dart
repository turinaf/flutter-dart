import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messsage;
  MessageBubble(this.messsage);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(12),
            ),
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              messsage,
              style: TextStyle(
                color: Theme.of(context).accentTextTheme.headline1!.color,
              ),
            )),
      ],
    );
  }
}
