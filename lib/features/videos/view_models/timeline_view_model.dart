import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/repository/videos_repository.dart';

import '../models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];
  late final VideosRepository _videosRepository;

  @override
  FutureOr<List<VideoModel>> build() async {
    _videosRepository = ref.read(videosRepository);
    final result = await _videosRepository.fetchVideos();
    final newList =
        result.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
    _list = newList;
    // throw Exception("Fetching failed");
    return _list;
  }

  Future<void> uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 5));
    final newVideo = VideoModel.dummy();
    //_list = [..._list, newVideo];
    _list.add(newVideo);
    state = AsyncValue.data(_list);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
