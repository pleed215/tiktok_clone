import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatEmoji extends StatelessWidget {
  const ChatEmoji(
      {Key? key, required this.textEditingController, required this.emoji})
      : super(key: key);

  final TextEditingController textEditingController;
  final String emoji;

  void _onTap() {
    textEditingController.text =
        "${textEditingController.text} $emoji$emoji$emoji";
    textEditingController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: textEditingController.text.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16,
          vertical: Sizes.size6,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              Sizes.size20,
            ),
          ),
          color: Colors.grey.shade300,
        ),
        child: Text(
          "$emoji$emoji$emoji",
          style: const TextStyle(fontSize: Sizes.size24, letterSpacing: 2.0),
        ),
      ),
    );
  }
}
