import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chat_screen.dart';

class DirectMessageScreen extends StatefulWidget {
  const DirectMessageScreen({
    Key? key,
  }) : super(key: key);
  static String routeName = "chats";
  static String routeUrl = "/chats";

  @override
  State<DirectMessageScreen> createState() => _DirectMessageScreenState();
}

class _DirectMessageScreenState extends State<DirectMessageScreen> {
  final _key = GlobalKey<AnimatedListState>();
  final _duration = const Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(0);
      _items.add(_items.length);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direct Messages"),
        elevation: 1,
        actions: [
          IconButton(
              onPressed: _addItem,
              icon: const FaIcon(
                FontAwesomeIcons.plus,
              ))
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        initialItemCount: 0,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: ListTile(
                onLongPress: () {
                  _deleteItem(index);
                },
                onTap: () {
                  // TODO: id는 하드코딩 되어 있어서 나중에 바꿔줘야 한다.
                  context.pushNamed(ChatScreen.routeName, params: {
                    'id': '1',
                  });
                  context.push('1');
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => const ChatScreen(),
                  // ));
                },
                leading: const CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/101641035?v=4'),
                  child: Text('Fk'),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Fork you ${_items[index]} item",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("PM 11:00",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: Sizes.size12,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                subtitle: const Text("You will regret"),
              ),
            ),
          );
        },
      ),
    );
  }
}
