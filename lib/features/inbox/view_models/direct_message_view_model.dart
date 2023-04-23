import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/repository/chatroom_repository.dart';
import 'package:tiktok_clone/features/user/repository/user_repository.dart';

import '../../authentication/repository/authentication_repository.dart';
import '../../user/models/user_profile_model.dart';

class DirectMessageViewModel extends AsyncNotifier<List<UserProfileModel>> {
  late final ChatRoomRepository _chatRoomRepository;

  @override
  FutureOr<List<UserProfileModel>> build() async {
    _chatRoomRepository = ref.read(chatRoomRepository);
    return await fetchUserList();
  }

  Future<List<UserProfileModel>> fetchUserList() async {
    final user = ref.read(authRepo).user;
    return ref.read(userRepository).getUserLists(user!.uid);
  }

  Future<String?> getRoomIdByPartnerId(String partnerId) async {
    final user = ref.read(authRepo).user;
    return _chatRoomRepository.getRoomIdByPartnerId(user!.uid, partnerId);
  }

  Future<String> createChatRoom(String partnerId, String partnerName) async {
    final user = ref.read(authRepo).user;
    final userData = await ref.read(userRepository).findProfile(user!.uid);
    final userProfile = UserProfileModel.fromMap(userData!);
    final createdChatRoomId = await ref
        .read(chatRoomRepository)
        .createChatRoom(user!.uid, userProfile.name, partnerId, partnerName);
    return createdChatRoomId;
  }
}

final directMessageProvider =
    AsyncNotifierProvider<DirectMessageViewModel, List<UserProfileModel>>(
        () => DirectMessageViewModel());
