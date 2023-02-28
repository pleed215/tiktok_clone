import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatAvatar extends StatelessWidget {
  const ChatAvatar(
      {Key? key, required this.backgroundImage, this.isActive = true})
      : super(key: key);

  final ImageProvider<Object> backgroundImage;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: Sizes.size24,
          backgroundImage: backgroundImage,
        ),
        Positioned(
          right: -Sizes.size2,
          bottom: -Sizes.size2,
          child: Container(
            width: Sizes.size16,
            height: Sizes.size16,
            decoration: BoxDecoration(
              color: isActive ? Colors.lightGreen : Colors.redAccent,
              shape: BoxShape.circle,
              border: Border.all(
                width: Sizes.size3,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
