import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

import '../authentication/widgets/interest_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 100.0) {
        _showTitle = true;
      } else {
        _showTitle = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1.0 : 0.0,
          duration: const Duration(
            milliseconds: 300,
          ),
          child: const Text("Choose your interests"),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size24,
              right: Sizes.size24,
              bottom: Sizes.size6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  'Choose your interests',
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                Text('Get better video recommendations',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    )),
                Gaps.v64,
                Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: [
                    for (var interest in interests)
                      InterestButton(interest: interest)
                  ],
                ),
              ],
            )),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 1,
          child: Padding(
              padding: const EdgeInsets.only(
                bottom: Sizes.size40,
                top: Sizes.size16,
                left: Sizes.size24,
                right: Sizes.size24,
              ),
              child: CupertinoButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: const Text("Next"),
              )
              // child: Container(
              //   padding: EdgeInsets.symmetric(
              //     vertical: Sizes.size20,
              //   ),
              //   decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              //   child: Text("Next",
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: Sizes.size16,
              //       )),
              // ),
              )),
    );
  }
}
