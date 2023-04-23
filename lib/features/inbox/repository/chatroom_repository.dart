import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomRepository {
  final _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchChatRooms(String uid) async {
    return await _db
        .collection("users")
        .doc(uid)
        .collection('chat_rooms')
        .get();
  }

  Future<String?> getRoomIdByPartnerId(String userId, String partnerId) async {
    final chatroom = await _db
        .collection('users')
        .doc(userId)
        .collection('chat_rooms')
        .where('partnerId', isEqualTo: partnerId)
        .get();
    if (chatroom.docs.isNotEmpty) {
      return chatroom.docs.first.data()['chatRoomId'];
    }
    return null;
  }

  Future<String> createChatRoom(String userId, String userName,
      String partnerId, String partnerName) async {
    final createdRef = await _db.collection('chat_rooms').add({
      "createAt": DateTime.now().millisecondsSinceEpoch,
      "userIds": ["${userId}___$userName", "${partnerId}___$partnerName"],
    });
    final document = await createdRef.get();
    return document.id;
  }
}

final chatRoomRepository = Provider((ref) => ChatRoomRepository());
