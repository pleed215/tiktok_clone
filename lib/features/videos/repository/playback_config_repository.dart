import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const _autoplayKey = 'autoplay';
  static const _mutedKey = 'muted';
  final SharedPreferences _pref;

  PlaybackConfigRepository(this._pref);

  Future<void> setMuted(bool value) async {
    await _pref.setBool(_mutedKey, value);
  }

  Future<void> setAutoplay(bool value) async {
    await _pref.setBool(_autoplayKey, value);
  }

  bool getMuted() {
    return _pref.getBool(_mutedKey) ?? false;
  }

  bool getAutoplay() {
    return _pref.getBool(_autoplayKey) ?? false;
  }
}
