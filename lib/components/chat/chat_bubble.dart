import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hackpue/components/chat/typing_indicator.dart';
import 'package:hackpue/constants.dart';

class ChatBubble extends StatelessWidget {
  final Function()? onLongPress;
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser, this.onLongPress});
  @override
  Widget build(BuildContext context) {
    var newMessage = utf8.encode(message);

    var marginOnUser = isCurrentUser
        ? const EdgeInsets.only(right: 20, top: 5, bottom: 5, left: 75)
        : const EdgeInsets.only(right: 20, top: 5, bottom: 5, left: 20);
    if (message == '-LOADING-') {
      return const SizedBox(
          height: 60,
          width: 100,
          child: Row(
            children: [
              TypingIndicator(
                showIndicator: true,
              ),
            ],
          ));
    } else {
      return GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          decoration: BoxDecoration(
            color: isCurrentUser ? happyYellow : happyOrange,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          margin: marginOnUser,
          child: SelectableText(
            utf8.decode(newMessage),
            style: TextStyle(color: defaultText),
          ),
        ),
      );
    }
  }
}
