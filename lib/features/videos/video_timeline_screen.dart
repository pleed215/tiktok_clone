import 'dart:math';

import 'package:flutter/material.dart';

const colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.teal,
  Colors.deepPurple,
  Colors.redAccent,
];

Color getRandomColor() {
  final random = Random();
  return colors[random.nextInt(colors.length)];
}

final hugeContainer = [
  for (int i = 0; i < 1000; i++)
    Container(
      color: getRandomColor(),
      child: Center(
        child: Text(
          '${i + 1}',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
];

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({Key? key}) : super(key: key);

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _currentItemLength = 5;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _currentItemLength,
      onPageChanged: (value) {
        if (_currentItemLength - value <= 2 && value % 5 == 3) {
          print('$value, $_currentItemLength');
          _pageController.animateTo(0,
              duration: const Duration(
                milliseconds: 1000,
              ),
              curve: Curves.linearToEaseOut);
          setState(() {
            _currentItemLength += 5;
          });
        }
      },
      itemBuilder: (context, index) {
        return hugeContainer[index];
      },
    );
  }
}
