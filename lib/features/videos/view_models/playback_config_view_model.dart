import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repository/playback_config_repository.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  bool get muted => state.muted;

  bool get autoplay => state.autoplay;

  PlaybackConfigViewModel(this._repository);

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.getMuted(),
      autoplay: _repository.getAutoplay(),
    );
  }

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(muted: value, autoplay: state.autoplay);
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(muted: state.muted, autoplay: value);
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
        () => throw UnimplementedError());
