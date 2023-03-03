import 'package:flutter/material.dart';

enum FollowInfoType {
  follower,
  following,
  like,
}

class FollowInfo extends StatelessWidget {
  final FollowInfoType type;

  const FollowInfo({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
