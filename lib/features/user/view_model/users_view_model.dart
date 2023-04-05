import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/respository/authentication_repository.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/user/models/user_profile_model.dart';
import 'package:tiktok_clone/features/user/repository/user_repository.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepository);
    _authRepository = ref.read(authRepo);
    if (_authRepository.isLoggedIn) {
      final profile =
          await _userRepository.findProfile(_authRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromMap(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not found");
    }
    state = const AsyncValue.loading();
    final signUpForm = ref.read(signUpFormStateProvider.notifier).state;
    final profile = UserProfileModel(
      bio: "",
      link: "",
      uid: credential.user!.uid,
      name: signUpForm['username'] ?? "Noname",
      birthday: signUpForm['birthday'],
      email: credential.user!.email ?? "anonymous",
      hasAvatar: false,
    );

    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> updateBio(String bio) async {
    if (state.value != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        await _userRepository.updateUser(state.value!.uid, {'bio': bio});
        return state.value!.copyWith(bio: bio);
      });
    }
  }

  Future<void> updateLink(String link) async {
    if (state.value != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        await _userRepository.updateUser(state.value!.uid, {'link': link});
        return state.value!.copyWith(link: link);
      });
    }
  }

  Future<void> onAvatarUpload() async {
    if (state.value != null) {
      state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
      await _userRepository.updateUser(state.value!.uid, {'hasAvatar': true});
    }
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
