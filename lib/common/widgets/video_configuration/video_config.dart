import 'package:flutter/material.dart';

class VideoConfig extends InheritedWidget {
  bool autoMute = false;

  VideoConfig({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static VideoConfig of(BuildContext context) {
    final VideoConfig? result =
        context.dependOnInheritedWidgetOfExactType<VideoConfig>();
    assert(result != null, 'No VideoConfig found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(VideoConfig old) {
    return true;
  }
}
