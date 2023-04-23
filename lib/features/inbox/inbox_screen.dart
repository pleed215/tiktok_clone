import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/direct_message_screen.dart';
import 'package:tiktok_clone/features/inbox/view_models/chatrooms_view_model.dart';

import 'chat_screen.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({Key? key}) : super(key: key);

  void _onTabDm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const DirectMessageScreen(),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.read(authRepo).user;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text("Inbox"),
          actions: [
            IconButton(
              splashRadius: 0.1,
              onPressed: () => _onTabDm(context),
              icon: const FaIcon(FontAwesomeIcons.paperPlane),
            ),
          ],
        ),
        body: Column(children: [
          ListTile(
            splashColor: Colors.transparent,
            title: const Text(
              "Activity",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.size16 + Sizes.size2),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.black,
            ),
            onTap: () {
              context.pushNamed(ActivityScreen.routeName);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const ActivityScreen(),
              //   ),
              // );
            },
          ),
          Container(height: Sizes.size1, color: Colors.grey.shade200),
          ListTile(
            title: const Text(
              "New Followers",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Sizes.size16),
            ),
            subtitle: const Text("Messages from followers will appear here",
                style: TextStyle(
                  fontSize: Sizes.size14,
                )),
            leading: Container(
              width: Sizes.size40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: ref.watch(chatRoomStream(authUser!.uid)).when(
                data: (chatRooms) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final chatWith = chatRooms[index].partnerName;
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(ChatScreen.routeName, params: {
                            'id': chatRooms[index].chatRoomId,
                          });
                        },
                        child: ListTile(
                          title: Text(
                            "Chat with: $chatWith",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size16),
                          ),
                          subtitle: Text(
                              "Tap here and talk with $chatWith more message",
                              style: const TextStyle(
                                fontSize: Sizes.size14,
                              )),
                          leading: Container(
                            width: Sizes.size40,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            child: Center(
                              child: CircleAvatar(
                                child: Text(chatWith.substring(0, 3)),
                              ),
                            ),
                          ),
                          trailing: const FaIcon(
                            FontAwesomeIcons.chevronRight,
                            size: Sizes.size14,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    itemCount: chatRooms.length,
                  );
                },
                error: (error, stackTrace) => Center(
                        child: Text(
                      "${error.toString()}:${stackTrace.toString()}",
                    )),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          )
        ]));
  }
}
