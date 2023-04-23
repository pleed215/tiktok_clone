import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/message.dart';

class MessageRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(
    MessageModel message,
    String chatRoomId,
  ) async {
    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toMap());
  }

  Future<void> makeDeleted(String chatRoomId, String messageId) async {
    await _db
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .doc(messageId)
        .update({"text": "[deleted message]"});
  }
}

final messageRepository = Provider(
  (ref) => MessageRepository(),
);
