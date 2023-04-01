import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

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

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({Key? key}) : super(key: key);

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _currentItemLength = 5;
  final _pageController = PageController();

  void _onVideoPlayFinished() {
    // _pageController.nextPage(
    //     duration: _scrollDuration, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos: $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          data: (videos) => RefreshIndicator(
            displacement: 50,
            edgeOffset: 10,
            backgroundColor: Colors.white.withOpacity(0.1),
            color: Theme.of(context).primaryColor,
            onRefresh: _onRefresh,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              onPageChanged: (value) {
                if (_currentItemLength - value <= 2 && value % 5 == 3) {
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
                return VideoPost(
                    onVideoFinished: _onVideoPlayFinished, index: index);
              },
            ),
          ),
        );
  }
}
