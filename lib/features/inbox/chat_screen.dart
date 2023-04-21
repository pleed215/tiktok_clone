import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tiktok_clone/features/inbox/view_models/message_view_model.dart';
import 'package:tiktok_clone/features/inbox/widgets/bubble_chat.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_avatar.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_emoji.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_widget.dart';

import '../../common/is_dark.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const String routeName = 'chat';
  static const String routeUrl = ':id';

  final String chatId;

  const ChatScreen({
    Key? key,
    required this.chatId,
  }) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _textEditingController = TextEditingController();
  bool _isDirty = false;
  late final _userId = ref.read(authRepo).user?.uid;
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
      final message = _textEditingController.text.trim();
      ref
          .read(messageSendProvider(widget.chatId).notifier)
          .sendMessage(message);
      setState(() {
        _hardCodingChats.add(ChatMessage(message, true));
      });
      _textEditingController.clear();
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
    final isDark = isDarkMode(context);
    final isSending = ref.watch(messageSendProvider(widget.chatId)).isLoading;
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
                size: Sizes.size20,
              ),
              Gaps.h20,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            ref.watch(messageStreamProvider(widget.chatId)).when(
                  data: (data) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    });

                    return ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.only(
                          left: Sizes.size14,
                          right: Sizes.size14,
                          top: Sizes.size16,
                          bottom: MediaQuery.of(context).padding.bottom + 140,
                        ),
                        itemBuilder: (context, index) {
                          final isMine = _userId == data[index].userId;
                          return ChatWidget(
                            message: ChatMessage(data[index].text, isMine),
                          );
                        },
                        separatorBuilder: (context, index) => Gaps.v10,
                        itemCount: data.length);
                  },
                  error: (error, stackTrace) => Center(child: Text('$error')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                color: isDark ? null : Colors.grey.shade100,
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
                              color: (_isDirty && !isSending)
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              shape: const CircleBorder(),
                            ),
                            child: IconButton(
                              onPressed: isSending ? null : _addItem,
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
      ),
    );
  }
}
