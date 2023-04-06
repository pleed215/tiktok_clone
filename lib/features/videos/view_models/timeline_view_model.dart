import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [
    VideoModel.dummy(),
  ];

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 3));
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
