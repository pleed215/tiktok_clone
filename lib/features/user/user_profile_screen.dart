import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/user/widgets/follow_info.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text(
            "FIFA",
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.bell,
                size: Sizes.size20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.ellipsis, size: Sizes.size20),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                foregroundColor: Colors.teal,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/101641035?v=4"),
                child: Text("Fork"),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "@pleed215",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.h10,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Colors.blue.shade500,
                    size: Sizes.size16,
                  ),
                ],
              ),
              Gaps.v24,
              SizedBox(
                height: Sizes.size40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FollowInfo(
                      num: 4300,
                      type: FollowInfoTypeEnum.follower,
                    ),
                    VerticalDivider(
                      color: Colors.grey.shade500,
                      width: 30.0,
                      thickness: 1.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    const FollowInfo(
                      num: 43000,
                      type: FollowInfoTypeEnum.following,
                    ),
                    VerticalDivider(
                      color: Colors.grey.shade500,
                      width: 30.0,
                      thickness: 1.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    const FollowInfo(
                      num: 4400000,
                      type: FollowInfoTypeEnum.like,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
