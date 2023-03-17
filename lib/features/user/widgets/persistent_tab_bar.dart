import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/is_dark.dart';
import '../../../constants/sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
        horizontal: BorderSide(
          color: Colors.grey.shade200,
          width: 0.5,
        ),
      )),
      child: TabBar(
          labelPadding: const EdgeInsets.only(
            bottom: Sizes.size10,
          ),
          labelColor: Theme.of(context).tabBarTheme.labelColor,
          indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
                child: Icon(Icons.grid_4x4_rounded)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
              child: FaIcon(FontAwesomeIcons.heart),
            ),
          ]),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
