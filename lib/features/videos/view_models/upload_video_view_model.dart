import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/user/view_model/users_view_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

import '../../authentication/respository/authentication_repository.dart';
import '../repository/videos_repository.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _videosRepository;

  @override
  FutureOr<void> build() {
    _videosRepository = ref.read(videosRepository);
  }

  // TODO: Challenge. On preview screen, make a form for getting information of video.
  Future<void> uploadVideo(File video) async {
    final userId = ref.read(authRepo).user?.uid;
    final userProfile = ref.read(usersProvider).value;
    if (userId == null || userProfile == null) {
      state =
          AsyncValue.error(Exception("Not authenticated"), StackTrace.current);
      return;
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final task = await _videosRepository.uploadVideo(userId, video);
      if (task.metadata != null) {
        final videoModel = VideoModel(
          title: "for testing",
          description: "for testing...",
          fileUrl: await task.ref.getDownloadURL(),
          thumbnailUrl: "",
          creatorUid: userId,
          creator: userProfile.name,
          likes: 0,
          comments: 0,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );
        await _videosRepository.saveVideo(videoModel);
      }
    });
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
    () => UploadVideoViewModel());
