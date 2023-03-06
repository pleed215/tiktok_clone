import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/format_large_number.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

const unsplashImages = [
  'https://images.unsplash.com/photo-1678005217231-1ea717fb2429?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1587&q=80',
  'https://images.unsplash.com/photo-1677763472056-52de795aabd4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1588&q=80',
  'https://images.unsplash.com/photo-1677856217269-b6ae0c14c9bd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1587&q=80',
  'https://images.unsplash.com/photo-1678003453277-1f99eb33c805?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1587&q=80',
  'https://images.unsplash.com/photo-1677928707977-bb4c3b4adc1a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1587&q=80',
  'https://images.unsplash.com/photo-1677577438000-bc7e1e228b88?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1587&q=80',
  'https://plus.unsplash.com/premium_photo-1666787754217-347de10a0948?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1587&q=80',
];
final imagePickRandom = Random();

class ProfileGridItem extends StatelessWidget {
  final bool pinned;
  final int views;
  final int randomPhoto = imagePickRandom.nextInt(unsplashImages.length);

  ProfileGridItem({
    Key? key,
    this.pinned = false,
    this.views = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          placeholderFit: BoxFit.fill,
          placeholder: 'assets/images/placeholder2.png',
          image: unsplashImages[randomPhoto],
        ),
        if (pinned)
          Positioned(
            left: Sizes.size4,
            top: Sizes.size2,
            child: Container(
                padding: const EdgeInsets.all(
                  Sizes.size2,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Sizes.size3),
                  ),
                ),
                child: const Text("Pinned",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ))),
          ),
        Positioned(
          left: Sizes.size4,
          bottom: Sizes.size2,
          child: Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.play,
                color: Colors.white,
                size: Sizes.size14,
              ),
              Gaps.h4,
              Text(
                formatLargeNumber(views),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
