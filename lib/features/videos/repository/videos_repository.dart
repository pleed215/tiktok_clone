import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/video_model.dart';

const pageSize = 2;

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideo(String userId, File video) {
    final fileRef = _storage.ref().child(
        '/videos/$userId/${DateTime.now().millisecondsSinceEpoch.toString()}');
    return fileRef.putFile(video);
  }

  Future<void> saveVideo(VideoModel data) async {
    await _db.collection('videos').add(data.toMap());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos(
      {int? lastItemCreatedAt}) {
    final orderedQuery = _db
        .collection('videos')
        .orderBy("createdAt", descending: true)
        .limit(pageSize);
    if (lastItemCreatedAt == null) {
      return orderedQuery.get();
    }
    return orderedQuery.startAfter([lastItemCreatedAt]).get();
  }

  Future<void> likeVideo(String videoId, String userId) async {
    final query = _db.collection('likes').doc("${videoId}000$userId");
    final doc = await query.get();
    if (!doc.exists) {
      await query.set({"createdAt": DateTime.now().millisecondsSinceEpoch});
    } else {
      await query.delete();
    }
  }
}

final videosRepository = Provider(
  (ref) => VideosRepository(),
);
