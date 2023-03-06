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
        return 'Follower';
      case FollowInfoTypeEnum.following:
        return 'Following';
      default:
        return 'Like';
    }
  }
}

class FollowInfo extends StatelessWidget {
  final FollowInfoTypeEnum type;
  final int num;

  const FollowInfo({Key? key, required this.num, required this.type})
      : super(key: key);

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
          "${type.info}${num > 1 && type != FollowInfoTypeEnum.follower ? 's' : ''}",
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
