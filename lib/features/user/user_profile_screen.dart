import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/setting_screen.dart';
import 'package:tiktok_clone/features/user/view_model/users_view_model.dart';
import 'package:tiktok_clone/features/user/widgets/avatar.dart';
import 'package:tiktok_clone/features/user/widgets/follow_info.dart';
import 'package:tiktok_clone/features/user/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/user/widgets/profile_grid_item.dart';

import '../../common/is_dark.dart';

final myRandom = Random();

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  final int views = (myRandom.nextDouble() * 1000000).toInt();

  void _onTapGear(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        centerTitle: true,
                        title: const Text(
                          "FIFA",
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          IconButton(
                            onPressed: () => _onTapGear(context),
                            icon: const FaIcon(FontAwesomeIcons.gear,
                                size: Sizes.size20),
                          )
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: const FaIcon(
                          //     FontAwesomeIcons.bell,
                          //     size: Sizes.size20,
                          //   ),
                          // ),
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: const FaIcon(FontAwesomeIcons.ellipsis,
                          //       size: Sizes.size20),
                          // ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: Breakpoints.md.toDouble(),
                          ),
                          child: Column(
                            children: [
                              Avatar(
                                  name: data.name,
                                  hasAvatar: data.hasAvatar,
                                  uid: data.uid),
                              Gaps.v20,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "@${data.name}",
                                    style: const TextStyle(
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
                                height: Sizes.size48,
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
                                      indent: 15.0,
                                      endIndent: 15.0,
                                    ),
                                    const FollowInfo(
                                      num: 43000,
                                      type: FollowInfoTypeEnum.following,
                                    ),
                                    VerticalDivider(
                                      color: Colors.grey.shade500,
                                      width: 30.0,
                                      thickness: 1.0,
                                      indent: 15.0,
                                      endIndent: 15.0,
                                    ),
                                    const FollowInfo(
                                      num: 4400000,
                                      type: FollowInfoTypeEnum.like,
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.v14,
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: FractionallySizedBox(
                                        widthFactor: 0.33,
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: Sizes.size16,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius: const BorderRadius
                                                      .all(
                                                  Radius.circular(Sizes.size4)),
                                            ),
                                            child: const Text(
                                              'Follow',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            )),
                                      ),
                                    ),
                                    Gaps.h4,
                                    Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(
                                          Sizes.size16,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              Sizes.size2,
                                            ),
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.youtube,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          size: Sizes.size14,
                                        )),
                                    Gaps.h4,
                                    Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: Sizes.size20,
                                          vertical: Sizes.size16,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              Sizes.size2,
                                            ),
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.caretDown,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          size: Sizes.size14,
                                        )),
                                  ],
                                ),
                              ),
                              Gaps.v14,
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.size32),
                                child: Text(
                                  "When the kraken falls for la marsa beach, all wenchs break proud, warm lagoons.Onuss studere in domesticus brigantium!",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Gaps.v14,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  FaIcon(FontAwesomeIcons.link,
                                      size: Sizes.size12),
                                  Gaps.h4,
                                  Text('https://wolbae.co.kr',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              ),
                              Gaps.v5,
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                          floating: true,
                          pinned: true,
                          delegate: PersistentTabBar())
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size4,
                        ),
                        itemCount: 20,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).size.width >=
                                  Breakpoints.md.toDouble()
                              ? 6
                              : 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 9 / 13.5,
                        ),
                        itemBuilder: (context, index) {
                          return ProfileGridItem(
                            views: views,
                            pinned: index % 4 == 0,
                          );
                        },
                      ),
                      const Center(child: Text("Page2")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
