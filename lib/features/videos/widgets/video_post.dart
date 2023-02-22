import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost(
      {Key? key, required this.index, required this.onVideoFinished})
      : super(key: key);
  final Function onVideoFinished;
  final int index;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final _videoPlayerController =
      VideoPlayerController.asset("assets/videos/sample.mov");
  bool _isPlaying = true;
  late final AnimationController _animationController;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: const Duration(milliseconds: 300),
    );
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1.0 &&
            !_videoPlayerController.value.isPlaying) {
          _videoPlayerController.play();
          setState(() {
            _isPlaying = true;
          });
        }
      },
      key: Key("${widget.index}"),
      child: Stack(children: [
        Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.teal,
                  )),
        Positioned.fill(
          child: GestureDetector(onTap: () {
            if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
              _isPlaying = false;
              _animationController.reverse();
            } else {
              _videoPlayerController.play();
              _animationController.forward();
              _isPlaying = true;
            }
            setState(() {});
          }),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child,
                  );
                },
                child: AnimatedOpacity(
                  opacity: _isPlaying ? 0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: const FaIcon(
                    FontAwesomeIcons.play,
                    color: Colors.white,
                    size: Sizes.size52,
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
