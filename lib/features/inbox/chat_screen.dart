import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/widgets/bubble_chat.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_avatar.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_emoji.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textEditingController = TextEditingController();
  bool _isDirty = false;
  final _hardCodingChats = [
    ChatMessage("Hahahahahaha", true),
    ChatMessage("👍👍👍", true),
    ChatMessage("😂😂😂", true),
    ChatMessage("❤️❤️❤️", true),
    ChatMessage("Hahahahahaha", false),
    ChatMessage("👍👍👍", false),
    ChatMessage("😂😂😂", false),
    ChatMessage("❤️❤️❤️", false),
  ];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onChange);
  }

  void _onChange() {
    setState(() {
      _isDirty = _textEditingController.text.isNotEmpty;
    });
  }

  void _addItem() {
    if (_isDirty) {
      setState(() {
        _hardCodingChats
            .add(ChatMessage(_textEditingController.text.trim(), true));
      });
      _textEditingController.clear();
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onChange);
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
              controller: _scrollController,
              padding: const EdgeInsets.only(
                left: Sizes.size14,
                right: Sizes.size14,
                top: Sizes.size16,
                bottom: 250,
              ),
              itemBuilder: (context, index) =>
                  ChatWidget(message: _hardCodingChats[index]),
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: _hardCodingChats.length),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
                vertical: Sizes.size10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ChatEmoji(
                            textEditingController: _textEditingController,
                            emoji: "❤️"),
                        Gaps.h4,
                        ChatEmoji(
                            textEditingController: _textEditingController,
                            emoji: "😂"),
                        Gaps.h4,
                        ChatEmoji(
                            textEditingController: _textEditingController,
                            emoji: "👍"),
                      ],
                    ),
                  ),
                  Gaps.v4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                  ),
                  Gaps.v4,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BubbleChat(
                        textEditingController: _textEditingController,
                      ),
                      Gaps.h10,
                      Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: Sizes.size44,
                          height: Sizes.size44,
                          decoration: ShapeDecoration(
                            color: _isDirty
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            shape: const CircleBorder(),
                          ),
                          child: IconButton(
                            onPressed: _addItem,
                            icon: const FaIcon(
                              FontAwesomeIcons.solidPaperPlane,
                              color: Colors.white,
                              size: Sizes.size20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
