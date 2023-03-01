import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';

class ChatMessage {
  final String message;
  final bool isMine;
  late final bool isEmoji;

  ChatMessage(this.message, this.isMine) {
    final isWord = RegExp(r"\w+|\d+|\s+|['-*/!@#$%^&]");
    isEmoji = !isWord.hasMatch(message);
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.message}) : super(key: key);
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (message.isEmoji)
          Text(message.message,
              style: const TextStyle(
                fontSize: Sizes.size52,
                letterSpacing: Sizes.size6,
              )),
        if (!message.isEmoji)
          Container(
            decoration: BoxDecoration(
              color: message.isMine ? Colors.cyan : Colors.purple,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(
                  Sizes.size20,
                ),
                topRight: const Radius.circular(
                  Sizes.size20,
                ),
                bottomLeft: Radius.circular(
                  message.isMine ? Sizes.size20 : Sizes.size5,
                ),
                bottomRight: Radius.circular(
                  !message.isMine ? Sizes.size20 : Sizes.size5,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
                vertical: Sizes.size14,
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                  fontSize: Sizes.size20,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
