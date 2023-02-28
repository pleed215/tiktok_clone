import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/widgets/bubble_chat.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_avatar.dart';

class ChatMessage {
  final String message;
  final bool isMine;
  late final bool isEmoji;

  ChatMessage(this.message, this.isMine) {
    final isWord = RegExp(r"\w+|\d+|\s+|['-*/!@#$%^&]");
    isEmoji = !isWord.hasMatch(message);
  }
}

final hardCodingChats = [
  ChatMessage("Hahahahahaha", true),
  ChatMessage("👍👍👍", true),
  ChatMessage("😂😂😂", true),
  ChatMessage("❤️❤️❤️", true),
  ChatMessage("Hahahahahaha", false),
  ChatMessage("👍👍👍", false),
  ChatMessage("😂😂😂", false),
  ChatMessage("❤️❤️❤️", false),
];

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

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: const ChatAvatar(
            backgroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/101641035?v=4"),
            isActive: true,
          ),
          title: const Text(
            "User is talking with you",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h20,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
                vertical: Sizes.size16,
              ),
              itemBuilder: (context, index) =>
                  ChatWidget(message: hardCodingChats[index]),
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: hardCodingChats.length),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
                vertical: Sizes.size10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(children: [
                      CustomPaint(
                        painter: const BubbleShape(color: Colors.white),
                        child: Container(height: 70.0),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size10,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Send a message..."),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Gaps.h10,
                  Center(
                    child: Container(
                      width: Sizes.size44,
                      height: Sizes.size44,
                      decoration: const ShapeDecoration(
                        color: Colors.grey,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                          color: Colors.grey,
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.solidPaperPlane,
                            color: Colors.white,
                            size: Sizes.size20,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
