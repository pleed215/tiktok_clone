import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tiktok_clone/features/inbox/models/message.dart';
import 'package:tiktok_clone/features/inbox/repository/message_repository.dart';

class MessageViewModel extends FamilyAsyncNotifier<void, String> {
  late final MessageRepository _messageRepository;
  late final String _chatRoomId;

  @override
  FutureOr<void> build(arg) {
    _chatRoomId = arg;
    _messageRepository = ref.read(messageRepository);
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(text: text, userId: user!.uid);
      _messageRepository.sendMessage(message, _chatRoomId);
    });
  }
}

final messageSendProvider =
    AsyncNotifierProvider.family<MessageViewModel, void, String>(
        () => MessageViewModel());
final messageStreamProvider = StreamProvider.autoDispose
    .family<List<MessageModel>, String>((ref, chatRoomId) {
  final db = FirebaseFirestore.instance;
  return db
      .collection('chat_rooms')
      .doc(chatRoomId)
      .collection('messages')
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) =>
            event.docs.map((e) => MessageModel.fromMap(e.data())).toList(),
      );
});
