import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/format_large_number.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

enum FollowInfoTypeEnum {
  follower,
  following,
  like,
}

extension FollowInfoType on FollowInfoTypeEnum {

  String get info {
    switch (this) {
      case FollowInfoTypeEnum.follower:
        return 'Followers';
      case FollowInfoTypeEnum.following:
        return 'Followings';
      default:
        return 'Likes';
    }
  }
}

class FollowInfo extends StatelessWidget {
  final FollowInfoTypeEnum type;
  final int num;

  const FollowInfo({Key? key, required this.num, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(formatLargeNumber(num),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size16,
            )),
        Gaps.v5,
        Text(
          type.info,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
