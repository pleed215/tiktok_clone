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
    _list = await _fetchVideos();
    return _list;
  }

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _videosRepository.fetchVideos(
        lastItemCreatedAt: lastItemCreatedAt);
    return result.docs
        .map(
          (e) => VideoModel.fromMap(e.data(), e.id),
        )
        .toList();
  }

  fetchNextPage() async {
    final nextPage =
        await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 5));
    final newVideo = VideoModel.dummy();
    //_list = [..._list, newVideo];
    _list.add(newVideo);
    state = AsyncValue.data(_list);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _list = videos;
    state = AsyncValue.data(videos);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
