import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room.dart';
import 'package:tiktok_clone/features/inbox/repository/chatroom_repository.dart';

class ChatRoomViewModel extends AsyncNotifier<List<ChatRoomModel>> {
  late final ChatRoomRepository _chatRoomRepository;

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    final user = ref.read(authRepo).user;
    _chatRoomRepository = ref.read(chatRoomRepository);
    final chatRoomsSnapshot =
        await _chatRoomRepository.fetchChatRooms(user!.uid);
    return chatRoomsSnapshot.map((e) {
      final userIds = (e.data()['userIds'] as List<dynamic>).cast<String>();
      return ChatRoomModel(id: e.id, userIds: userIds);
    }).toList();
  }
}

final chatRoomProvider =
    AsyncNotifierProvider<ChatRoomViewModel, List<ChatRoomModel>>(
        () => ChatRoomViewModel());
