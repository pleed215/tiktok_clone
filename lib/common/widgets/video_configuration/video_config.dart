import 'package:flutter/material.dart';

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoPlay = false;
  bool isDarkMode = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoPlay() {
    isAutoPlay = !isAutoPlay;
    notifyListeners();
  }

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
