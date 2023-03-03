import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/sizes.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Center(
        child: FaIcon(
          FontAwesomeIcons.chevronLeft,
          color: Colors.black,
          size: Sizes.size16,
        ),
      ),
    );
  }
}
