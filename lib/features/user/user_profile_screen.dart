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
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
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
                icon:
                    const FaIcon(FontAwesomeIcons.ellipsis, size: Sizes.size20),
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
                FractionallySizedBox(
                  widthFactor: 0.33,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size16,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.all(
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
                Gaps.v14,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                  child: Text(
                    "When the kraken falls for la marsa beach, all wenchs break proud, warm lagoons.Onuss studere in domesticus brigantium!",
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v14,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(FontAwesomeIcons.link, size: Sizes.size12),
                    Gaps.h4,
                    const Text('https://wolbae.co.kr',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
                Gaps.v5,
                Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.grey.shade200,
                      width: 0.5,
                    ),
                  )),
                  child: const TabBar(
                      labelPadding: EdgeInsets.only(
                        bottom: Sizes.size10,
                      ),
                      labelColor: Colors.black,
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Sizes.size10),
                            child: Icon(Icons.grid_4x4_rounded)),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.size10),
                          child: FaIcon(FontAwesomeIcons.heart),
                        ),
                      ]),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size4,
                          horizontal: Sizes.size4,
                        ),
                        itemCount: 20,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: Sizes.size4,
                          mainAxisSpacing: Sizes.size12,
                          childAspectRatio: 9 / 16,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size4),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 0.8,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholderFit: BoxFit.fitHeight,
                                    placeholder:
                                        'assets/images/placeholder.png',
                                    image:
                                        'https://images.unsplash.com/photo-1544717304-a2db4a7b16ee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1588&q=80',
                                  ),
                                ),
                              ),
                              Gaps.v10,
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Stella de altus lanista, locus abaculus! Warp tightly like a colorful transformator. One must emerge the saint in order to gain the aspect of sincere control.",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: Sizes.size16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gaps.v4,
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 12,
                                          backgroundImage: NetworkImage(
                                            "https://avatars.githubusercontent.com/u/101641035?v=4",
                                          ),
                                        ),
                                        Gaps.h4,
                                        Expanded(
                                          child: Text(
                                            "Long Person Name",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: Sizes.size16,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ),
                                        Gaps.h3,
                                        Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.heart,
                                              color: Colors.grey.shade500,
                                              size: Sizes.size16,
                                            ),
                                            Gaps.h3,
                                            Text(
                                              '3.3M',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Sizes.size12,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Center(child: Text("Page2")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
