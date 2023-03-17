import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class ActivityMenu extends StatelessWidget {
  final IconData icon;
  final String menu;
  final Function()? onTap;
  final bool check;

  const ActivityMenu(this.icon, this.menu,
      {Key? key, this.onTap, this.check = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          Icon(
            icon,
            size: Sizes.size14,
            color: Theme.of(context).textTheme.headlineSmall?.color,
          ),
          Gaps.h20,
          Text(
            menu,
            style: const TextStyle(
              fontSize: Sizes.size16,
            ),
          ),
        ],
      ),
      trailing: check
          ? FaIcon(
              FontAwesomeIcons.check,
              size: Sizes.size14,
              color: Theme.of(context).primaryColor,
            )
          : null,
    );
  }
}
