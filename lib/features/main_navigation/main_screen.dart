import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final _screens = const [
    Center(
      child: Text('home'),
    ),
    Center(
      child: Text('Discover'),
    ),
    Center(
      child: Text('add'),
    ),
    Center(
      child: Text('inbox'),
    ),
    Center(
      child: Text('profile'),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            child: _screens[0],
            offstage: _currentIndex != 0,
          ),
          Offstage(
            child: _screens[1],
            offstage: _currentIndex != 1,
          ),
          Offstage(
            child: _screens[2],
            offstage: _currentIndex != 2,
          ),
          Offstage(
            child: _screens[3],
            offstage: _currentIndex != 3,
          ),
          Offstage(
            child: _screens[4],
            offstage: _currentIndex != 4,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black,
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
              ),
              NavTab(
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                text: "Discover",
                isSelected: _currentIndex == 1,
                onTap: () => _onTap(1),
              ),
              Gaps.h10,
              const NavAddButton(),
              Gaps.h10,
              NavTab(
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                text: "Inbox",
                isSelected: _currentIndex == 3,
                onTap: () => _onTap(3),
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                text: "Profile",
                isSelected: _currentIndex == 4,
                onTap: () => _onTap(4),
              ),
            ],
          )),
    );
  }
}

class NavAddButton extends StatefulWidget {
  const NavAddButton({
    super.key,
  });

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
              appBar: AppBar(
                title: Text('Video Records'),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
                child: const Center(
                  child: FaIcon(FontAwesomeIcons.plus, color: Colors.black),
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
  });

  final String? text;
  final bool isSelected;
  final IconData icon;
  final GestureTapCallback onTap;
  final IconData selectedIcon;

  @override
  State<NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<NavTab> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedOpacity(
        opacity: widget.isSelected ? 1 : 0.6,
        duration: const Duration(
          milliseconds: 300,
        ),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  widget.isSelected ? widget.selectedIcon : widget.icon,
                  color: Colors.white,
                ),
                Gaps.v5,
                if (widget.text != null)
                  Text(widget.text!,
                      style: const TextStyle(
                        color: Colors.white,
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
