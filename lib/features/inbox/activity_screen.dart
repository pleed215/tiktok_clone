import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/inbox/widgets/activity_menu.dart';

import '../../constants/sizes.dart';
import 'direct_message_screen.dart';

List<ActivityMenu> activityMenus = [
  const ActivityMenu(
    FontAwesomeIcons.solidCommentDots,
    "All activity",
  ),
  const ActivityMenu(FontAwesomeIcons.solidHeart, "Likes"),
  const ActivityMenu(FontAwesomeIcons.commentDots, "Comments"),
  const ActivityMenu(FontAwesomeIcons.at, "Mentions"),
  const ActivityMenu(FontAwesomeIcons.solidUser, "Followers"),
  const ActivityMenu(FontAwesomeIcons.tiktok, "From TikTok"),
];

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(
    20,
    (index) => '$index item',
  );
  late final _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 150));
  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);
  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);
  late final Animation<Color?> _colorAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black54,
  ).animate(_animationController);
  bool _modalOpen = false;

  @override
  void initState() {
    super.initState();
  }

  void _onToggleAnimation() {
    if (_animationController.isCompleted) {
      _animationController.reverse().whenComplete(() => setState(() {
            _modalOpen = !_modalOpen;
          }));
      return;
    }
    _animationController.forward();
    setState(() {
      _modalOpen = !_modalOpen;
    });
  }

  void _onTapDm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const DirectMessageScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onToggleAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "All Activity",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.h4,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size12,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 0.1,
            onPressed: () => _onTapDm(context),
            icon: const FaIcon(FontAwesomeIcons.paperPlane),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size10,
                ),
                child: Text(
                  "New",
                  style: TextStyle(
                      fontSize: Sizes.size14, color: Colors.grey.shade500),
                ),
              ),
              Gaps.v14,
              for (final item in _notifications)
                Dismissible(
                  key: Key("$item Key"),
                  onDismissed: (direction) {
                    final index = _notifications.indexOf(item);
                    _notifications.removeAt(index);
                    setState(() {});
                  },
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                        padding: EdgeInsets.only(
                          left: Sizes.size10,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.checkDouble,
                          color: Colors.white,
                          size: Sizes.size20,
                        )),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                        padding: EdgeInsets.only(
                          right: Sizes.size10,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                          size: Sizes.size20,
                        )),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0.0,
                      vertical: Sizes.size6,
                    ),
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: Sizes.size1,
                        ),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                          text: "Account updates:",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(
                                text: " Upload long videos.",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                )),
                            TextSpan(
                                text: " $item",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey.shade500))
                          ]),
                    ),
                    trailing: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      color: Colors.grey.shade500,
                      size: Sizes.size16,
                    ),
                  ),
                ),
            ],
          ),
          if (_modalOpen)
            AnimatedModalBarrier(
              color: _colorAnimation,
              onDismiss: _onToggleAnimation,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Sizes.size5),
                      bottomRight: Radius.circular(Sizes.size5),
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final widget in activityMenus) widget,
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
