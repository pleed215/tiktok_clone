import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';

import '../../constants/sizes.dart';

enum Direction { left, right }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.left;
  Page _page = Page.first;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            setState(() {
              _direction = Direction.right;
            });
          } else {
            setState(() {
              _direction = Direction.left;
            });
          }
        },
        onPanEnd: (details) {
          if (_direction == Direction.left) {
            setState(() {
              _page = Page.second;
            });
          } else {
            setState(() {
              _page = Page.first;
            });
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: AnimatedCrossFade(
              firstChild: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v52,
                    const Text(
                      'What cool videos!',
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
              ),
              secondChild: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v52,
                    const Text(
                      'Follow the rules',
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      'Take care of one another, please',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
              ),
              duration: const Duration(milliseconds: 300),
              crossFadeState: _page == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size48,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _page == Page.second ? 1.0 : 0.0,
              child: CupertinoButton(
                onPressed: () {
                  context.go('/home');
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(
                  //       builder: (context) => const MainScreen(),
                  //     ),
                  //     (route) => false);
                },
                color: Theme.of(context).primaryColor,
                child: const Text("Enter the app!"),
              ),
            ),
          )),
        ));
  }
}
