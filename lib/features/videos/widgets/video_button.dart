import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  const VideoButton(
      {Key? key,
      required this.icon,
      required this.text,
      this.onTap,
      this.color = Colors.white,
      this.iconSize = Sizes.size40,
      this.fontSize = Sizes.size16})
      : super(key: key);

  final IconData icon;
  final String text;
  final GestureTapCallback? onTap;
  final Color color;
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          FaIcon(
            icon,
            color: color,
            size: iconSize,
          ),
          Gaps.v5,
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
