import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tiktok_clone/features/user/repository/user_repository.dart';
import 'package:tiktok_clone/features/user/view_model/users_view_model.dart';

class AvatarViewModel extends AsyncNotifier {
  late final UserRepository _userRepository;

  @override
  FutureOr build() {
    _userRepository = ref.read(userRepository);
  }

  Future<void> uploadAvatar(File imageFile) async {
    state = const AsyncValue.loading();
    final userId = ref.read(authRepo).user?.uid;
    if (userId == null) return;
    state = await AsyncValue.guard(() async {
      _userRepository.uploadAvatar(imageFile, userId);
      ref.read(usersProvider.notifier).onAvatarUpload();
    });
  }
}

final avatarProvider =
    AsyncNotifierProvider<AvatarViewModel, void>(() => AvatarViewModel());
