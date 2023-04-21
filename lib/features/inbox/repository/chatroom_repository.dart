import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchChatRooms(
      String uid) async {
    final snapshot = await _db.collection('chat_rooms').get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredDocs = [];
    for (final doc in snapshot.docs) {
      List<String> userIds = (doc['userIds'] as List<dynamic>).cast<String>();
      if (userIds.isEmpty) {
        return filteredDocs;
      }
      final isContainId =
          userIds.any((userId) => userId.startsWith('${uid}___'));
      if (isContainId) {
        filteredDocs.add(doc);
      }
    }

    return filteredDocs;
  }
}

final chatRoomRepository = Provider((ref) => ChatRoomRepository());
