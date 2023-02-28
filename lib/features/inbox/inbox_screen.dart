import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/direct_message_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  void _onTabDm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const DirectMessageScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ActivityScreen(),
                ),
              );
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
        ],
      ),
    );
  }
}
