import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/show_firebase_error.dart';
import 'package:tiktok_clone/features/videos/view_models/upload_video_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    Key? key,
    required this.video,
    required this.isPicked,
  }) : super(key: key);

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _onTapSave() async {
    if (_savedVideo) {
      return;
    }
    _savedVideo = true;

    await GallerySaver.saveVideo(widget.video.path, albumName: "TikTok clone");
    setState(() {});
  }

  void _onTapUpload() async {
    try {
      await ref.read(uploadVideoProvider.notifier).uploadVideo(
            File(widget.video.path),
          );
    } catch (e) {
      showFirebaseErrorOnSnackBar(context, e);
      return;
    }
    if (context.mounted) {
      showSuccessMessage(context, "Video upload completed");
      context.pushReplacement('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _onTapSave,
              icon: FaIcon(
                _savedVideo
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed:
                ref.watch(uploadVideoProvider).isLoading ? () {} : _onTapUpload,
            icon: ref.watch(uploadVideoProvider).isLoading
                ? const CircularProgressIndicator()
                : const FaIcon(FontAwesomeIcons.cloudArrowUp),
          )
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
