import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chat_screen.dart';
import 'package:tiktok_clone/features/inbox/view_models/direct_message_view_model.dart';

import '../user/models/user_profile_model.dart';

class DirectMessageScreen extends ConsumerStatefulWidget {
  const DirectMessageScreen({
    Key? key,
  }) : super(key: key);
  static String routeName = "chats";
  static String routeUrl = "/chats";

  @override
  ConsumerState<DirectMessageScreen> createState() =>
      _DirectMessageScreenState();
}

class _DirectMessageScreenState extends ConsumerState<DirectMessageScreen> {
  final _key = GlobalKey<AnimatedListState>();
  final _duration = const Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(0);
      _items.add(_items.length);
    }
  }

  void _startChat() async {
    if (_selectedUser != null) {
      var chatRoomId = await ref
          .read(directMessageProvider.notifier)
          .getRoomIdByPartnerId(_selectedUser!.uid);

      chatRoomId ??= await ref
          .read(directMessageProvider.notifier)
          .createChatRoom(_selectedUser!.uid, _selectedUser!.name);
      if (mounted) {
        context.pushNamed(ChatScreen.routeName, params: {'id': chatRoomId!});
      }
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
          index,
          duration: _duration,
          (context, animation) => SizeTransition(
                sizeFactor: animation,
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: FaIcon(
                      FontAwesomeIcons.trash,
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Removed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      )),
                  tileColor: Colors.red,
                ),
              ));
      _items.removeAt(index);
    }
  }

  final List<int> _items = [];
  int _selectedIndex = -1;
  UserProfileModel? _selectedUser = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Direct Messages"),
          elevation: 1,
          actions: [
            IconButton(
                onPressed: _startChat,
                icon: const FaIcon(
                  FontAwesomeIcons.plus,
                ))
          ],
        ),
        body: ref.watch(directMessageProvider).when(
              data: (data) {
                return AnimatedList(
                  key: _key,
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10,
                  ),
                  initialItemCount: data.length,
                  itemBuilder: (context, index, animation) {
                    return FadeTransition(
                      key: UniqueKey(),
                      opacity: animation,
                      child: SizeTransition(
                        sizeFactor: animation,
                        child: ListTile(
                          selected: _selectedIndex == index,
                          selectedTileColor: Colors.grey,
                          selectedColor: Colors.white,
                          trailing: IconButton(
                              onPressed: () {
                                _selectedIndex = index;
                                _selectedUser = data[index];
                                setState(() {});
                                _startChat();
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.chevronRight,
                              )),
                          onLongPress: () async {
                            _selectedUser = data[index];
                            _selectedIndex = index;
                            setState(() {});
                            _startChat();
                          },
                          onTap: () {
                            setState(() {
                              if (_selectedIndex == index) {
                                _selectedIndex = -1;
                                _selectedUser = null;
                              } else {
                                _selectedIndex = index;
                                _selectedUser = data[index];
                              }
                            });
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            child: Text(data[index].name.substring(0, 3)),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(data[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          subtitle:
                              Text("Tap here to chat with ${data[index].name}"),
                        ),
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                print(error.toString());
                return Center(
                    child:
                        Text("${error.toString()}: ${stackTrace.toString()}"));
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ));
  }
}
