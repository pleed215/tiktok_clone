import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/respository/authentication_repository.dart';
import 'package:tiktok_clone/features/videos/repository/videos_repository.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _videosRepository;
  late final String _videoId;

  @override
  FutureOr<void> build(String arg) {
    _videoId = arg;
    _videosRepository = ref.read(videosRepository);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _videosRepository.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
        () => VideoPostViewModel());
