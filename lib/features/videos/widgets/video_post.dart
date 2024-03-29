import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_view_model.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_viewmodel.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comment_modal.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import 'video_button.dart';

class VideoPost extends ConsumerStatefulWidget {
  const VideoPost(
      {Key? key,
      required this.index,
      required this.onVideoFinished,
      required this.videoData})
      : super(key: key);
  final Function onVideoFinished;
  final int index;
  final VideoModel videoData;

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final _videoPlayerController =
      VideoPlayerController.network(widget.videoData.fileUrl);
  bool _isPlaying = true;
  late final AnimationController _animationController;
  late bool _isMuted = ref.read(playbackConfigProvider).muted;
  bool _isLiked = false;
  late int _numLikes = widget.videoData.likes;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _toggleVolume() {
    _videoPlayerController.setVolume(_isMuted ? 0.8 : 0.0);
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
      setState(() {
        _isMuted = false;
      });
    }
    setState(() {});
    await _videoPlayerController.setLooping(true);
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
    ref
        .read(videoPostProvider(widget.videoData.id).notifier)
        .isLiked()
        .then((value) => _isLiked = value);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleVideoState() {
    if (_isPlaying && _videoPlayerController.value.isInitialized) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _onTapLike() {
    _numLikes = _isLiked ? _numLikes - 1 : _numLikes + 1;
    _isLiked = !_isLiked;
    ref.watch(videoPostProvider(widget.videoData.id).notifier).likeVideo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1.0 &&
            _isPlaying &&
            !_videoPlayerController.value.isPlaying) {
          final autoplay = ref.watch(playbackConfigProvider).autoplay;
          if (autoplay) {
            _videoPlayerController.play();
          } else {
            setState(() {
              _isPlaying = false;
            });
          }
        }
        if (info.visibleFraction == 0.0 &&
            _videoPlayerController.value.isPlaying) {
          //_toggleVideoState();
        }
      },
      key: Key("${widget.index}"),
      child: Stack(children: [
        Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
                  )),
        Positioned.fill(
          child: GestureDetector(
            onTap: _toggleVideoState,
          ),
        ),
        Positioned(
          top: Sizes.size52,
          right: Sizes.size10,
          child: GestureDetector(
            onTap: _toggleVolume,
            child: FaIcon(
              _isMuted
                  //_isMuted
                  ? FontAwesomeIcons.volumeXmark
                  : FontAwesomeIcons.volumeHigh,
              color: Colors.white,
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animationController.value,
                  child: child,
                );
              },
              child: Center(
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
        ),
        Positioned(
          bottom: 40,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.videoData.creator,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.size20,
                ),
              ),
              Gaps.v20,
              CollapsableText(
                text: widget.videoData.description,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 80,
          right: 10,
          child: Column(
            children: [
              CircleAvatar(
                radius: 25,
                foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/clone-tiktok-"
                    "pleed0215.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media"), //&sometrick=${DateTime.now()}"),
//                child: Text(widget.videoData.creator),
              ),
              Gaps.v24,
              GestureDetector(
                onTap: _onTapLike,
                child: VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  color: _isLiked ? Colors.redAccent : Colors.white,
                  text: S.of(context).likeCount(_numLikes),
                ),
              ),
              Gaps.v24,
              VideoButton(
                icon: FontAwesomeIcons.solidComment,
                text: S.of(context).commentCount(widget.videoData.comments),
                onTap: () {
                  // if(_videoPlayerController.value.isPlaying) {
                  // _toggleVideoState();
                  // }
                  _videoPlayerController
                      .pause()
                      .whenComplete(() => showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            constraints: const BoxConstraints(maxWidth: 500),
                            builder: (context) {
                              return const VideoCommentModal();
                            },
                          ).whenComplete(() {
                            if (_isPlaying) {
                              _videoPlayerController.play();
                            }
                          }));
                },
              ),
              Gaps.v24,
              const VideoButton(
                icon: FontAwesomeIcons.share,
                text: "Share",
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class CollapsableText extends StatefulWidget {
  final String text;
  final int length;

  const CollapsableText({super.key, required this.text, this.length = 20});

  @override
  State<CollapsableText> createState() => _CollapsableTextState();
}

class _CollapsableTextState extends State<CollapsableText> {
  late bool _isOverLength;
  bool _collapsed = true;

  @override
  void initState() {
    super.initState();
    _isOverLength = widget.text.length > widget.length;
  }

  String makeText() {
    if (_collapsed && _isOverLength) {
      return '${widget.text.substring(0, 16)} ...';
    } else {
      return widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          makeText(),
          style: const TextStyle(
            fontSize: Sizes.size16,
            color: Colors.white,
          ),
        ),
        Gaps.h4,
        if (_isOverLength && _collapsed)
          GestureDetector(
            onTap: () {
              setState(() {
                _collapsed = false;
              });
            },
            child: const Text(
              "See more",
              maxLines: 3,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold),
            ),
          )
      ],
    );
  }
}
