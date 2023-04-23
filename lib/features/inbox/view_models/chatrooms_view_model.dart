import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room.dart';
import 'package:tiktok_clone/features/inbox/repository/chatroom_repository.dart';

class ChatRoomViewModel extends AsyncNotifier<List<ChatRoomModel>> {
  late final ChatRoomRepository _chatRoomRepository;

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    _chatRoomRepository = ref.read(chatRoomRepository);
    return await refetchRooms();
  }

  Future<List<ChatRoomModel>> refetchRooms() async {
    final user = ref.read(authRepo).user;
    final chatRoomsSnapshot =
        await _chatRoomRepository.fetchChatRooms(user!.uid);
    return chatRoomsSnapshot.docs.map((e) {
      print(e.data());
      return ChatRoomModel.fromMap(e.data());
    }).toList();
  }
}

final chatRoomProvider =
    AsyncNotifierProvider<ChatRoomViewModel, List<ChatRoomModel>>(
        () => ChatRoomViewModel());

final chatRoomStream =
    StreamProvider.autoDispose.family<List<ChatRoomModel>, String>(
  (ref, userId) {
    final db = FirebaseFirestore.instance;
    return db
        .collection("users")
        .doc(userId)
        .collection("chat_rooms")
        .snapshots()
        .map(
          (event) => event.docs
              .map((room) => ChatRoomModel.fromMap(room.data()))
              .toList(),
        );
  },
);
