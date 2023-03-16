import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/user/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

import '../../common/is_dark.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 4;
  final _screens = [
    const VideoTimelineScreen(),
    const DiscoverScreen(),
    const Center(
      child: Text('add'),
    ),
    const InboxScreen(),
    const UserProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _currentIndex == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _currentIndex != 0,
            child: _screens[0],
          ),
          Offstage(
            offstage: _currentIndex != 1,
            child: _screens[1],
          ),
          Offstage(
            offstage: _currentIndex != 2,
            child: _screens[2],
          ),
          Offstage(
            offstage: _currentIndex != 3,
            child: _screens[3],
          ),
          Offstage(
            offstage: _currentIndex != 4,
            child: _screens[4],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: _currentIndex == 0 || isDark ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size8,
            horizontal: Sizes.size16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.solidHandSpock,
                text: "Home",
                isSelected: _currentIndex == 0,
                onTap: () => _onTap(0),
                currentIndex: _currentIndex,
              ),
              NavTab(
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                text: "Discover",
                isSelected: _currentIndex == 1,
                onTap: () => _onTap(1),
                currentIndex: _currentIndex,
              ),
              Gaps.h10,
              NavAddButton(
                inverted: _currentIndex != 0 && !isDark,
              ),
              Gaps.h10,
              NavTab(
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                text: "Inbox",
                isSelected: _currentIndex == 3,
                onTap: () => _onTap(3),
                currentIndex: _currentIndex,
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                text: "Profile",
                isSelected: _currentIndex == 4,
                onTap: () => _onTap(4),
                currentIndex: _currentIndex,
              ),
            ],
          )),
    );
  }
}

class NavAddButton extends StatefulWidget {
  const NavAddButton({
    super.key,
    required this.inverted,
  });

  final bool inverted;

  @override
  State<NavAddButton> createState() => _NavAddButtonState();
}

class _NavAddButtonState extends State<NavAddButton> {
  bool _longTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => setState(() {
        _longTapped = true;
      }),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: widget.inverted ? Colors.black : Colors.white,
              appBar: AppBar(
                title: const Text('Video Records'),
              ),
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: AnimatedRotation(
        turns: _longTapped ? 10.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        onEnd: () => setState(() {
          _longTapped = false;
        }),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 8,
              child: Container(
                height: 35,
                width: 45,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size8,
                ),
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
              ),
            ),
            Positioned(
              left: 8,
              child: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
              ),
            ),
            Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: widget.inverted ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
                child: Center(
                  child: FaIcon(FontAwesomeIcons.plus,
                      color: widget.inverted ? Colors.white : Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}

class NavTab extends StatefulWidget {
  const NavTab({
    super.key,
    this.text,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.currentIndex,
  });

  final String? text;
  final bool isSelected;
  final IconData icon;
  final GestureTapCallback onTap;
  final IconData selectedIcon;
  final int currentIndex;

  @override
  State<NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<NavTab> {
  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Expanded(
      child: AnimatedOpacity(
        opacity: widget.isSelected ? 1 : 0.6,
        duration: const Duration(
          milliseconds: 300,
        ),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: widget.currentIndex == 0 || isDark
                  ? Colors.black
                  : Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  widget.isSelected ? widget.selectedIcon : widget.icon,
                  color: widget.currentIndex == 0 || isDark
                      ? Colors.white
                      : Colors.black,
                ),
                Gaps.v5,
                if (widget.text != null)
                  Text(widget.text!,
                      style: TextStyle(
                        color: widget.currentIndex == 0 || isDark
                            ? Colors.white
                            : Colors.black,
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
